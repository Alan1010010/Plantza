import Typed from 'typed.js';

const loadDynamicBannerText = () => {
  if (document.querySelector('#banner-typed-text')) {
    new Typed('#banner-typed-text', {
      strings: ["Jungle-themed birthday party?", "Temporary air purification?", "We've got you covered."],
      typeSpeed: 50,
      showCursor: false,
      backDelay: 1500,
    });
  }
}

export { loadDynamicBannerText };
