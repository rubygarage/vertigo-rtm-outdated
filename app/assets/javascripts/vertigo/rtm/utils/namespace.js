(function (global) {
  global.namespace = function(namespaceString) {
    var namespaceParts = namespaceString.split('.'),
        parent = global,
        currentPart;

    for (var i = 0; i < namespaceParts.length; i++) {
      currentPart = namespaceParts[i];
      parent[currentPart] = parent[currentPart] || {};
      parent = parent[currentPart];
    }

    return parent;
  };
})(window);
