# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "bootstrap", to: "bootstrap.min.js", preload: true
pin "@popperjs/core", to: "popper.js", preload: true
pin "stimulus" # @3.2.2
pin "chartkick" # @5.0.1
pin "chart.js" # @4.4.1
pin "@kurkle/color", to: "@kurkle--color.js" # @0.3.2
pin "mapbox-gl" # @3.1.2
pin "process" # @2.0.1
pin "flatpickr" # @4.6.13
pin "typed.js" # @2.1.0
