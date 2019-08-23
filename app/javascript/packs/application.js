import "bootstrap";
import 'mapbox-gl/dist/mapbox-gl.css';
import { initMapbox } from '../plugins/init_mapbox';
import { initStarRating } from '../plugins/init_star_rating';
import { loadDynamicBannerText } from '../components/banner';

loadDynamicBannerText();
initStarRating();
initMapbox();


