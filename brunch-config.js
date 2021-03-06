exports.config = {
  // See http://brunch.io/#documentation for docs.
  files: {
    javascripts: {
      // To use a separate vendor.js bundle, specify two files path
      // http://brunch.io/docs/config#-files-
      joinTo: "js/app.js",

      //
      // To change the order of concatenation of files, explicitly mention here
      order: {
        before: [
          "web/static/vendor/js/jquery-2.2.4.min.js",
          "web/static/vendor/js/bootstrap.js",
          "web/static/vendor/js/moment.js"
        ]
      }
    },
    stylesheets: {
      joinTo: {
        "css/app.css" : /^web\/static\/css\/(?!session.scss)/,
        "css/session.css" : /^web\/static\/css\/session.scss/
      }
    }
  },

  conventions: {
    // This option sets where we should place non-css and non-js assets in.
    // By default, we set this to "/web/static/assets". Files in this directory
    // will be copied to `paths.public`, which is "priv/static" by default.
    assets: /^(web\/static\/assets)/
  },

  // Phoenix paths configuration
  paths: {
    // Dependencies and current project directories to watch
    watched: [
      "web/static",
      "test/static"
    ],

    // Where to compile files to
    public: "priv/static"
  },

  // Configure your plugins
  plugins: {
    babel: {
      // Do not use ES6 compiler in vendor code
      ignore: [/web\/static\/vendor/]
    },
    sass: {
      mode: 'native',
      options: {
        includePaths: [
          "web/static/vendor/css"
        ]
      }
    }
  },

  modules: {
    autoRequire: {
      "js/app.js": ["web/static/js/app"]
    }
  },

  npm: {
    enabled: true
  }
};
