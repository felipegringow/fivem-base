"use strict";

var DEFAULT_SIZE = 100;
var MIN_SECTORS = 3;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function RadialMenu(params) {
  var self = this;

  self.parent = params.parent || [];

  self.size = params.size || DEFAULT_SIZE;
  self.onClick = params.onClick || null;
  self.isNight = params.isNight
  self.menuItems = params.menuItems
    ? params.menuItems
    : [
        { id: "one", title: "One" },
        { id: "two", title: "Two" },
      ];

  self.radius = 45;
  self.innerRadius = self.radius * 0.4;
  self.sectorSpace = 0;
  self.sectorCount = Math.max(self.menuItems.length, MIN_SECTORS);
  self.closeOnClick = params.closeOnClick !== undefined ? !!params.closeOnClick : false;

  self.scale = 1;
  self.holder = null;
  self.parentMenu = [];
  self.parentItems = [];
  self.levelItems = null;

  self.createHolder();
  self.addIconSymbols();

  self.currentMenu = null;

  self.bindedOnMouseWheel = self.onMouseWheel.bind(this);
  self.bindedOnKeyDown = self.onKeyDown.bind(this);

  document.addEventListener("wheel", self.bindedOnMouseWheel);
  document.addEventListener("keydown", self.bindedOnKeyDown);
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
RadialMenu.prototype.open = function () {
  var self = this;
  if (!self.currentMenu) {
    self.currentMenu = self.createMenu("menu inner", self.menuItems);
    self.holder.appendChild(self.currentMenu);

    // wait DOM commands to apply and then set class to allow transition to take effect
    RadialMenu.nextTick(function () {
      self.currentMenu.setAttribute("class", "menu");
    });
  }
};

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
RadialMenu.prototype.close = function () {
  var self = this;

  if (self.currentMenu) {
    var parentMenu;
    while ((parentMenu = self.parentMenu.pop())) {
      parentMenu.remove();
    }
    self.parentItems = [];

    RadialMenu.setClassAndWaitForTransition(self.currentMenu, "menu inner").then(function () {
      self.currentMenu.remove();
      self.currentMenu = null;
    });

    document.removeEventListener("wheel", self.bindedOnMouseWheel);
    document.removeEventListener("keydown", self.bindedOnKeyDown);

    $.post(`https://${GetParentResourceName()}/close`);
  }
};

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
RadialMenu.prototype.getParentMenu = function () {
  var self = this;
  if (self.parentMenu.length > 0) {
    return self.parentMenu[self.parentMenu.length - 1];
  } else {
    return null;
  }
};

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
RadialMenu.prototype.createHolder = function () {
  var self = this;

  self.holder = document.createElement("div");
  self.holder.className = "menuHolder";
  self.holder.style.width = self.size + "px";
  self.holder.style.height = self.size + "px";

  self.parent.appendChild(self.holder);
};

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
RadialMenu.prototype.showNestedMenu = function (item) {
  var self = this;
  self.parentMenu.push(self.currentMenu);
  self.parentItems.push(self.levelItems);
  self.currentMenu = self.createMenu("menu inner", item.items, true, item.title);
  self.holder.appendChild(self.currentMenu);

  // wait DOM commands to apply and then set class to allow transition to take effect
  RadialMenu.nextTick(function () {
    self.getParentMenu().setAttribute("class", "menu outer");
    self.currentMenu.setAttribute("class", "menu");
  });
};

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
RadialMenu.prototype.returnToParentMenu = function () {
  var self = this;
  self.getParentMenu().setAttribute("class", "menu");
  RadialMenu.setClassAndWaitForTransition(self.currentMenu, "menu inner").then(function () {
    self.currentMenu.remove();
    self.currentMenu = self.parentMenu.pop();
    self.levelItems = self.parentItems.pop();
  });
};

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
RadialMenu.prototype.handleClick = function () {
  var self = this;

  var selectedIndex = self.getSelectedIndex();
  if (selectedIndex >= 0) {
    var item = self.levelItems[selectedIndex];
    if (item.items) {
      self.showNestedMenu(item);
    } else {
      if (self.onClick) {
        self.onClick(item);
        if (self.closeOnClick) {
          self.close();
        }
      }
    }
  }
};

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
RadialMenu.prototype.handleCenterClick = function () {
  var self = this;
  if (self.parentItems.length > 0) {
    self.returnToParentMenu();
  } else {
    self.close();
  }
};

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
RadialMenu.prototype.createCenter = function (svg, title, icon, size) {
  var self = this;
  size = size || 8;
  var g = document.createElementNS("http://www.w3.org/2000/svg", "g");
  g.setAttribute("class", "center");

  var centerCircle = self.createCircle(0, 0, self.innerRadius - self.sectorSpace / 3);
  g.appendChild(centerCircle);
  if (title) {
    var text = self.createText(0, 4, title);
    
    g.appendChild(text);
  }

  if (icon) {
    var use = self.createUseTag(0, title ? -4 : 0, icon, size);
    use.setAttribute("width", size);
    use.setAttribute("height", size);
    use.setAttribute(
      "transform",
      "translate(-" + RadialMenu.numberToString(size / 2) + ",-" + RadialMenu.numberToString(size / 2) + ")"
    );
    g.appendChild(use);
  }

  svg.appendChild(g);
};

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
RadialMenu.prototype.getIndexOffset = function () {
  var self = this;
  if (self.levelItems.length < self.sectorCount) {
    switch (self.levelItems.length) {
      case 1:
        return -2;
      case 2:
        return -2;
      case 3:
        return -2;
      default:
        return -1;
    }
  } else {
    return -1;
  }
};

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
RadialMenu.prototype.createMenu = function (classValue, levelItems, nested, title) {
  var self = this;

  self.levelItems = levelItems;

  self.sectorCount = Math.max(self.levelItems.length, MIN_SECTORS);
  self.scale = self.calcScale();

  var svg = document.createElementNS("http://www.w3.org/2000/svg", "svg");
  svg.setAttribute("class", classValue);
  svg.setAttribute("viewBox", "-50 -50 100 100");
  svg.setAttribute("width", self.size);
  svg.setAttribute("height", self.size);

  var angleStep = 360 / self.sectorCount;
  var angleShift = angleStep / 2 + 270;

  var indexOffset = self.getIndexOffset();

  for (var i = 0; i < self.sectorCount; ++i) {
    var startAngle = angleShift + angleStep * i;
    var endAngle = angleShift + angleStep * (i + 1);

    var itemIndex = RadialMenu.resolveLoopIndex(self.sectorCount - i + indexOffset, self.sectorCount);
    var item;
    if (itemIndex >= 0 && itemIndex < self.levelItems.length) {
      item = self.levelItems[itemIndex];
    } else {
      item = null;
    }

    self.appendSectorPath(startAngle, endAngle, svg, item, itemIndex);
  }

  if (nested) {
    self.createCenter(svg, title, "icon bold repeat-circle", 8);
  } else {
    self.createCenter(svg, null, "icon bold close-circle", 12);
  }

  svg.addEventListener("mousedown", function (event) {
    var className = event.target.parentNode.getAttribute("class").split(" ")[0];
    switch (className) {
      case "sector":
        var index = parseInt(event.target.parentNode.getAttribute("data-index"));
        if (!isNaN(index)) {
          self.setSelectedIndex(index);
        }
        break;
      default:
    }
  });

  svg.addEventListener("click", function (event) {
    var className = event.target.parentNode.getAttribute("class").split(" ")[0];
    switch (className) {
      case "sector":
        self.handleClick();
        break;
      case "center":
        self.handleCenterClick();
        break;
      default:
    }
  });
  return svg;
};

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
RadialMenu.prototype.selectDelta = function (indexDelta) {
  var self = this;
  var selectedIndex = self.getSelectedIndex();
  if (selectedIndex < 0) {
    selectedIndex = 0;
  }
  selectedIndex += indexDelta;

  if (selectedIndex < 0) {
    selectedIndex = self.levelItems.length + selectedIndex;
  } else if (selectedIndex >= self.levelItems.length) {
    selectedIndex -= self.levelItems.length;
  }
  self.setSelectedIndex(selectedIndex);
};

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
RadialMenu.prototype.onKeyDown = function (event) {
  var self = this;
  if (self.currentMenu) {
    switch (event.key) {
      case "Escape":
      case "Backspace":
        self.handleCenterClick();
        event.preventDefault();
        break;
      case "Enter":
        self.handleClick();
        event.preventDefault();
        break;
      case "ArrowRight":
      case "ArrowUp":
        self.selectDelta(1);
        event.preventDefault();
        break;
      case "ArrowLeft":
      case "ArrowDown":
        self.selectDelta(-1);
        event.preventDefault();
        break;
    }
  }
};

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
RadialMenu.prototype.onMouseWheel = function (event) {
  var self = this;
  if (self.currentMenu) {
    var delta = -event.deltaY;

    if (delta > 0) {
      self.selectDelta(1);
    } else {
      self.selectDelta(-1);
    }
  }
};

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
RadialMenu.prototype.getSelectedNode = function () {
  var self = this;
  var items = self.currentMenu.getElementsByClassName("selected");
  if (items.length > 0) {
    return items[0];
  } else {
    return null;
  }
};

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
RadialMenu.prototype.getSelectedIndex = function () {
  var self = this;
  var selectedNode = self.getSelectedNode();
  if (selectedNode) {
    return parseInt(selectedNode.getAttribute("data-index"));
  } else {
    return -1;
  }
};

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
RadialMenu.prototype.setSelectedIndex = function (index) {
  var self = this;
  if (index >= 0 && index < self.levelItems.length) {
    var items = self.currentMenu.querySelectorAll('g[data-index="' + index + '"]');
    if (items.length > 0) {
      var itemToSelect = items[0];
      var selectedNode = self.getSelectedNode();
      if (selectedNode) {
        selectedNode.setAttribute("class", "sector");
      }
      itemToSelect.setAttribute("class", "sector selected");
    }
  }
};

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
RadialMenu.prototype.createUseTag = function (x, y, link, size) {
  let sizeIcon = size || 7;

  var use = document.createElementNS("http://www.w3.org/2000/svg", "foreignObject");

  use.innerHTML = `
        <div class="action-icon">
            <i class="${link}" style="font-size: ${sizeIcon}px"></i>
        </div>
    `;

  use.setAttribute("x", RadialMenu.numberToString(x));
  use.setAttribute("y", RadialMenu.numberToString(y));
  use.setAttribute("width", sizeIcon);
  use.setAttribute("height", sizeIcon);
  use.setAttribute("fill", "white");
  use.setAttributeNS("http://www.w3.org/1999/xlink", "xlink:href", link);
  return use;
};

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
RadialMenu.prototype.appendSectorPath = function (startAngleDeg, endAngleDeg, svg, item, index) {
  var self = this;

  var centerPoint = self.getSectorCenter(startAngleDeg, endAngleDeg);
  var translate = {
    x: RadialMenu.numberToString((1 - self.scale) * centerPoint.x),
    y: RadialMenu.numberToString((1 - self.scale) * centerPoint.y),
  };

  var g = document.createElementNS("http://www.w3.org/2000/svg", "g");
  g.setAttribute("transform", "translate(" + translate.x + " ," + translate.y + ") scale(" + self.scale + ")");

  var path = document.createElementNS("http://www.w3.org/2000/svg", "path");
  path.setAttribute("d", self.createSectorCmds(startAngleDeg, endAngleDeg));
  g.appendChild(path);

  if (self.isNight){
    g.setAttribute("fill", "rgba(150, 150, 150, 0.1)");
  } else {
    g.setAttribute("fill", "#19191980");
  }

  if (item) {
    g.setAttribute("class", "sector");
    if (index == 0) {
      g.setAttribute("class", "sector selected");
    }
    g.setAttribute("data-id", item.id);
    g.setAttribute("data-index", index);

    if (item.title) {
      var text = self.createText(centerPoint.x, centerPoint.y, item.title);
      if (item.icon) {
        text.setAttribute("transform", "translate(0,6)");
      } else {
        text.setAttribute("transform", "translate(0,2)");
      }

      g.appendChild(text);
    }

    if (item.icon) {
      var use = self.createUseTag(centerPoint.x, centerPoint.y, item.icon);
      if (item.title) {
        use.setAttribute("transform", "translate(-4,-6)");
      } else {
        use.setAttribute("transform", "translate(-4,-5)");
      }

      g.appendChild(use);
    }
  } else {
    g.setAttribute("class", "dummy");
  }

  svg.appendChild(g);
};

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
RadialMenu.prototype.createSectorCmds = function (startAngleDeg, endAngleDeg) {
  var self = this;

  var initPoint = RadialMenu.getDegreePos(startAngleDeg, self.radius);
  var path = "M" + RadialMenu.pointToString(initPoint);

  var radiusAfterScale = self.radius * (1 / self.scale);
  path +=
    "A" +
    radiusAfterScale +
    " " +
    radiusAfterScale +
    " 0 0 0" +
    RadialMenu.pointToString(RadialMenu.getDegreePos(endAngleDeg, self.radius));
  path += "L" + RadialMenu.pointToString(RadialMenu.getDegreePos(endAngleDeg, self.innerRadius));

  var radiusDiff = self.radius - self.innerRadius;
  var radiusDelta = (radiusDiff - radiusDiff * self.scale) / 2;
  var innerRadius = (self.innerRadius + radiusDelta) * (1 / self.scale);
  path +=
    "A" +
    innerRadius +
    " " +
    innerRadius +
    " 0 0 1 " +
    RadialMenu.pointToString(RadialMenu.getDegreePos(startAngleDeg, self.innerRadius));
  path += "Z";

  return path;
};

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
RadialMenu.prototype.createText = function (x, y, title) {
  var self = this;
  var text = document.createElementNS("http://www.w3.org/2000/svg", "text");
  text.setAttribute("text-anchor", "middle");
  text.setAttribute("x", RadialMenu.numberToString(x));
  text.setAttribute("y", RadialMenu.numberToString(y));
  text.setAttribute("font-size", "0.22rem");
  text.setAttribute("letter-spacing", 0.2);

  text.innerHTML = title;
  return text;
};

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
RadialMenu.prototype.createCircle = function (x, y, r) {
  var circle = document.createElementNS("http://www.w3.org/2000/svg", "circle");
  circle.setAttribute("cx", RadialMenu.numberToString(x));
  circle.setAttribute("cy", RadialMenu.numberToString(y));
  circle.setAttribute("r", r);
  return circle;
};

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
RadialMenu.prototype.calcScale = function () {
  var self = this;
  var totalSpace = self.sectorSpace * self.sectorCount;
  var circleLength = Math.PI * 2 * self.radius;
  var radiusDelta = self.radius - (circleLength - totalSpace) / (Math.PI * 2);
  return (self.radius - radiusDelta) / self.radius;
};

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
RadialMenu.prototype.getSectorCenter = function (startAngleDeg, endAngleDeg) {
  var self = this;
  return RadialMenu.getDegreePos(
    (startAngleDeg + endAngleDeg) / 2,
    self.innerRadius + (self.radius - self.innerRadius) / 2
  );
};

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
RadialMenu.prototype.addIconSymbols = function () {
  var self = this;
  var svg = document.createElementNS("http://www.w3.org/2000/svg", "svg");
  svg.setAttribute("class", "icons");

  // return
  var returnSymbol = document.createElementNS("http://www.w3.org/2000/svg", "symbol");
  returnSymbol.setAttribute("id", "return");
  returnSymbol.setAttribute("viewBox", "0 0 489.394 489.394");
  var returnPath = document.createElementNS("http://www.w3.org/2000/svg", "path");
  returnPath.setAttribute(
    "d",
    "M375.789,92.867H166.864l17.507-42.795c3.724-9.132,1-19.574-6.691-25.744c-7.701-6.166-18.538-6.508-26.639-0.879" +
      "L9.574,121.71c-6.197,4.304-9.795,11.457-9.563,18.995c0.231,7.533,4.261,14.446,10.71,18.359l147.925,89.823" +
      "c8.417,5.108,19.18,4.093,26.481-2.499c7.312-6.591,9.427-17.312,5.219-26.202l-19.443-41.132h204.886" +
      "c15.119,0,27.418,12.536,27.418,27.654v149.852c0,15.118-12.299,27.19-27.418,27.19h-226.74c-20.226,0-36.623,16.396-36.623,36.622" +
      "v12.942c0,20.228,16.397,36.624,36.623,36.624h226.74c62.642,0,113.604-50.732,113.604-113.379V206.709" +
      "C489.395,144.062,438.431,92.867,375.789,92.867z"
  );
  returnSymbol.appendChild(returnPath);
  svg.appendChild(returnSymbol);

  var closeSymbol = document.createElementNS("http://www.w3.org/2000/svg", "symbol");
  closeSymbol.setAttribute("id", "close");
  closeSymbol.setAttribute("viewBox", "0 0 41.756 41.756");

  var closePath = document.createElementNS("http://www.w3.org/2000/svg", "path");
  closePath.setAttribute(
    "d",
    "M27.948,20.878L40.291,8.536c1.953-1.953,1.953-5.119,0-7.071c-1.951-1.952-5.119-1.952-7.07,0L20.878,13.809L8.535,1.465" +
      "c-1.951-1.952-5.119-1.952-7.07,0c-1.953,1.953-1.953,5.119,0,7.071l12.342,12.342L1.465,33.22c-1.953,1.953-1.953,5.119,0,7.071" +
      "C2.44,41.268,3.721,41.755,5,41.755c1.278,0,2.56-0.487,3.535-1.464l12.343-12.342l12.343,12.343" +
      "c0.976,0.977,2.256,1.464,3.535,1.464s2.56-0.487,3.535-1.464c1.953-1.953,1.953-5.119,0-7.071L27.948,20.878z"
  );
  closeSymbol.appendChild(closePath);
  svg.appendChild(closeSymbol);

  self.holder.appendChild(svg);
};

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
RadialMenu.getDegreePos = function (angleDeg, length) {
  return {
    x: Math.sin(RadialMenu.degToRad(angleDeg)) * length,
    y: Math.cos(RadialMenu.degToRad(angleDeg)) * length,
  };
};

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
RadialMenu.pointToString = function (point) {
  return RadialMenu.numberToString(point.x) + " " + RadialMenu.numberToString(point.y);
};

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
RadialMenu.numberToString = function (n) {
  if (Number.isInteger(n)) {
    return n.toString();
  } else if (n) {
    var r = (+n).toFixed(5);
    if (r.match(/\./)) {
      r = r.replace(/\.?0+$/, "");
    }
    return r;
  }
};

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
RadialMenu.resolveLoopIndex = function (index, length) {
  if (index < 0) {
    index = length + index;
  }
  if (index >= length) {
    index = index - length;
  }
  if (index < length) {
    return index;
  } else {
    return null;
  }
};

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
RadialMenu.degToRad = function (deg) {
  return deg * (Math.PI / 180);
};

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
RadialMenu.setClassAndWaitForTransition = function (node, newClass) {
  return new Promise(function (resolve) {
    function handler(event) {
      if (event.target == node && event.propertyName == "visibility") {
        node.removeEventListener("transitionend", handler);
        resolve();
      }
    }
    node.addEventListener("transitionend", handler);
    node.setAttribute("class", newClass);
  });
};

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
RadialMenu.nextTick = function (fn) {
  setTimeout(fn, 10);
};


const isProduction = () => 'GetParentResourceName' in window

if (!isProduction()){
  const testeItens = [
    {
      id: "walk",
      title: "WALK",
      icon: "icon bold user",
    },
    {
      id: "run",
      title: "Run",
      icon: "icon bold user-add",
    },
    {
      id: "drive",
      title: "Drive",
      icon: "#drive",
    },
    {
      id: "figth",
      title: "Fight",
      icon: "#fight",
    },
    {
      id: "more",
      title: "More...",
      icon: "#more",
      items: [
        {
          id: "eat",
          title: "Eat",
          icon: "#eat",
        },
        {
          id: "sleep",
          title: "Sleep",
          icon: "#sleep",
        },
        {
          id: "shower",
          title: "Take Shower",
          icon: "#shower",
        },
        {
          id: "workout",
          icon: "#workout",
          title: "Work Out",
        },
      ],
    },
    {
      id: "weapon",
      title: "Weapon...",
      icon: "#weapon",
      items: [
        {
          id: "firearm",
          icon: "#firearm",
          title: "Firearm...",
          items: [
            {
              id: "glock",
              title: "Glock 22",
            },
            {
              id: "beretta",
              title: "Beretta M9",
            },
            {
              id: "tt",
              title: "TT",
            },
            {
              id: "m16",
              title: "M16 A2",
            },
            {
              id: "ak47",
              title: "AK 47",
            },
          ],
        },
        {
          id: "knife",
          icon: "#knife",
          title: "Knife",
        },
        {
          id: "machete",
          icon: "#machete",
          title: "Machete",
        },
        {
          id: "grenade",
          icon: "#grenade",
          title: "Grenade",
        },
      ],
    },
  ];
  
  window.addEventListener("DOMContentLoaded", () => {
    let menu = new RadialMenu({
      parent: document.getElementById("navMenu"),
      size: 500,
      closeOnClick: true,
      menuItems: testeItens,
      isNight: true,
      onClick: function (item) {
        console.log(item);
      },
    });
    menu.open();
  });
}

