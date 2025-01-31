import mapboxgl from "mapbox-gl";

const MapHook = {
  mounted() {
    mapboxgl.accessToken = this.el.dataset.accessToken;

    const map = new mapboxgl.Map({
      container: this.el.id,
      zoom: 15,
      center: [-117.91897, 33.81196],
    });

    this.handleEvent("add-marker", ({ location }) => {
      new mapboxgl.Marker().setLngLat(location).addTo(map);
    });
  },
};

export default MapHook;
