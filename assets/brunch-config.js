exports.config = {
  files: {
    javascripts: {
      joinTo: "js/app.js"
    },
    stylesheets: {
      joinTo: "css/app.css",
    },
    templates: {
      joinTo: "js/app.js"
    }
  },

  conventions: {
    assets: /^(static)/,
    ignored: [ "" ]
  },

  paths: {
    watched: ["static", "css", "js", "vendor"],
    public: "../priv/static"
  },

  plugins: {
    babel: {
      // Do not use ES6 compiler in vendor code
      ignore: [/vendor/]
    }
  },

  modules: {
    autoRequire: {
      "js/app.js": ["js/app"],
      "js/racer_controller.js": ["js/racer_controller"]
    }
  },

  npm: {
    enabled: true,
    styles: {
      "font-awesome":['css/font-awesome.css'],
      "bootswatch": ['dist/slate/bootstrap.css'],
      "bootstrap-social":['bootstrap-social.css'],
      "animate.css": ['animate.css']
    },
    javascripts:{
      "sprite-js": ['js/sprite.js']
    },
    globals:{
      Handlebars:'handlebars',
      bootstrap:'bootstrap',
      popper:"popper.js",
      $: 'jquery',
      jQuery: "jquery"
    }
  }
};
