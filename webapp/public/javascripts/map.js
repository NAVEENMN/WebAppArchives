// --------------------
mapboxgl.accessToken = 'pk.eyJ1IjoibXlzb3JuMSIsImEiOiIwODY0MDQ0ZTdiYTViYmU0ZTZiOGI4OTU5MjQxZGY1NCJ9.elqMFi4oQtFFjYXbW2Oxig';
var metrics_points = {
  "type": "FeatureCollection",
  "features": []
};
var metrics_points_attr = {
  "type": "FeatureCollection",
  "features": []
};
var yellow_dot_url='http://cortex-web-assets.s3-us-west-2.amazonaws.com/icons/yellowdot.png';
// --------------------

var satelliteMap = new mapboxgl.Map({
  container: 'satellite',
  style: 'mapbox://styles/mapbox/satellite-v9',
  center: [-74.50, 40],
  bearing: -12,
  zoom: 9
});
var streetsMap = new mapboxgl.Map({
  container: 'streets',
  style: 'mapbox://styles/mapbox/streets-v11',
  center: [-74.50, 40],
  bearing: -12,
  zoom: 9
});

var map = new mapboxgl.Compare(satelliteMap, streetsMap, {
  // Set this to enable comparing two maps by mouse movement:
  // mousemove: true
});


satelliteMap.on("style.load", function () {
  // Possible position values are 'bottom-left', 'bottom-right', 'top-left', 'top-right'
  satelliteMap.addControl(new mapboxgl.Minimap({
      center: [-74.50, 40],
      zoom: 4,
      zoomLevels: []
    }), 'bottom-left');


  satelliteMap.loadImage(yellow_dot_url, function(error, image) {
    if (error) throw error;
    satelliteMap.addImage('yellow_dot', image);
  });

  satelliteMap.addControl(draw);

  satelliteMap.addSource("metrics_points_attr", {"type": "geojson", "data": metrics_points_attr });
  satelliteMap.addLayer({
    "id": "metrics_points_attr",
    "type": "symbol",
    "source": "metrics_points_attr",
    "layout": {
      "icon-image": "yellow_dot",
      "icon-size": 0.25
    }
  });

  satelliteMap.addSource("metrics_points", { "type": "geojson", "data": metrics_points});
  satelliteMap.addLayer({
    "id": "metrics_points",
    "type": "symbol",
    "source": "metrics_points",
    "layout": {
      "text-field": ["get", "description"],
      "text-variable-anchor": ["top", "bottom", "left", "right"],
      "text-radial-offset": 0.5,
      "text-justify": "auto"
    },
    "paint":{
      "text-color": "#FFFF52",
      "text-halo-color": "#333301",
      "text-halo-width": 0.5,
      "text-halo-blur": 5
    }
  });

});

function getMethods(obj) {
  var result = [];
  for (var id in obj) {
    try {
      if (typeof(obj[id]) == "function") {
        result.push(id + ": " + obj[id].toString());
      }
    } catch (err) {
      result.push(id + ": inaccessible");
    }
  }
  for (var method in result) {
    console.log(result[method]);
  }
  return result;
}

var deltaDistance = 100;
var deltaDegrees = 5;
function easing(t) {
  return t * (2 - t);
}
satelliteMap.on('load', function() {
  satelliteMap.getCanvas().focus();
  satelliteMap.getCanvas().addEventListener('keydown', function(e) {
    e.preventDefault();
    console.log(e.which);

    // w button press
    if (e.which === 87) { // up
      satelliteMap.panBy([0, -deltaDistance], {
        easing: easing
        });
    } else if (e.which === 83) { // down
      satelliteMap.panBy([0, deltaDistance], {
        easing: easing
        });
    } else if (e.which === 65) { // left
      satelliteMap.panBy([-deltaDistance, 0], {
        easing: easing
        });
      console.log(e);
    } else if (e.which === 68) { // right
      satelliteMap.panBy([deltaDistance, 0], {
        easing: easing
        });
      console.log(e);
    } else if (e.which === 37) { // left arrow key
      getMethods(satelliteMap);
      satelliteMap.rotateTo(deltaDegrees);
      console.log(e);
    } else if (e.which === 39) { // right arrow key
      satelliteMap.easeTo({
        bearing: satelliteMap.getBearing() + deltaDegrees
      });
      console.log(e);
    }

  }, true);
});

satelliteMap.on('draw.create', computeMetrics);
satelliteMap.on('draw.delete', computeMetrics);
satelliteMap.on('draw.update', computeMetrics);

var draw = new MapboxDraw({
  displayControlsDefault: true,
  controls: {
    line_string: true,
    point: true,
    polygon: true,
    trash: true
  }
});

function changeLayer(obj){
  var layerId = obj.value;
  satelliteMap.setStyle('mapbox://styles/mapbox/' + layerId);
}

// https://turfjs.org/docs/
function computeDistance(from_location, to_location) {
  var from = turf.point(from_location);
  var to = turf.point(to_location);
  var options = {units: 'miles'};
  // you add extra args to convert units.
  var distance = turf.distance(from, to);
  distance = Math.round(distance * 100) / 100; // rounding to 2 decimals
  distance = String(distance) + " Km";
  return distance;
}

function computeLength(list_of_coordinates) {
  var line = turf.lineString(list_of_coordinates);
  var length = turf.lineDistance(line);
  length = Math.round(length * 100) / 100; // rounding to 2 decimals
  length = String(length) + " Km";
  return length;
}

function computeArea(list_of_coordinates) {
  var area = turf.area(list_of_coordinates);
  area = Math.round(area * 100) / 100; // rounding to 2 decimals
  area = String(area) + " Sqmt";
  return area;
}

function constructMetricPointAttr(coordinate, image_name) {
  obj = new Object();
  obj["type"] = "Feature";
  obj["geometry"] = {"type": "Point", "coordinates": coordinate};
  return obj;
}

function constructMetricPoint(coordinate, metric) {
  obj = new Object();
  obj["type"] = "Feature";
  obj["properties"] = {"description": metric};// "icon": "for icons"
  obj["geometry"] = {"type": "Point", "coordinates": coordinate};
  return obj;
}

function appenddistancesforsegments(coordinates, metrics_points) {
  var idx_a = 0;
  var idx_b = 0;
  for (idx_a=0,idx_b=1; idx_b<coordinates.length; idx_a++, idx_b++) {
    var distance = computeDistance(coordinates[idx_a], coordinates[idx_b]);
    var midpoint = turf.midpoint(coordinates[idx_a], coordinates[idx_b]);
    metric_point = constructMetricPoint(midpoint.geometry.coordinates, distance);
    metrics_points.features.push(metric_point);
  }
}

function computeMetrics(e) {
  var answer = document.getElementById('metrics');
  var data = draw.getAll();
  // remove all previous metrics
  while (metrics_points.features.length > 0) {
      metrics_points.features.pop();
  }
  while (metrics_points_attr.features.length > 0) {
      metrics_points_attr.features.pop();
  }
  // compute new metrics
  for (var i=0; i<data.features.length; i++) {
    var feature = data.features[i];
    if (feature.geometry.type == "LineString") {
      var coordinates = feature.geometry.coordinates;
      // compute distances between each segements of line
      // and append them to metrics_points
      appenddistancesforsegments(coordinates, metrics_points);
      // computer the total distance
      var length = computeLength(coordinates);
      var endpoint = coordinates[coordinates.length-1];
      metric_point_img = constructMetricPointAttr(endpoint, "yellow_dot_url");
      metric_point = constructMetricPoint(endpoint, length);
      metrics_points_attr.features.push(metric_point_img);
      metrics_points.features.push(metric_point);
    } else if (feature.geometry.type == "Polygon") {
      var coordinates = feature.geometry.coordinates[0];
      // compute distances between each segements of line
      // and append them to metrics_points
      appenddistancesforsegments(coordinates, metrics_points);
      // compute the area and append it to metrics_points
      area = computeArea(feature);
      var centroid = turf.centroid(feature);
      metric_point_img = constructMetricPointAttr(centroid.geometry.coordinates, "yellow_dot_url");
      metric_point = constructMetricPoint(centroid.geometry.coordinates, area);
      metrics_points_attr.features.push(metric_point_img);
      metrics_points.features.push(metric_point);
    }
  }
  // Add a GeoJSON source containing place coordinates and information.

  satelliteMap.getSource('metrics_points').setData(metrics_points);
  satelliteMap.getSource('metrics_points_attr').setData(metrics_points_attr);

}

satelliteMap.on('click', function (e) {

});

satelliteMap.on('mousemove', function (e) {
  document.getElementById('info').innerHTML =
  'x: '+e.point.x+' '+'y: '+e.point.y+
  // e.point is the x, y coordinates of the mousemove event relative
  // to the top-left corner of the map
  '<br />' +
  'lat: '+e.lngLat.lat+'<br />'+
  'long: '+e.lngLat.lng
  // e.lngLat is the longitude, latitude geographical position of the event
});
