{:user {:plugins [[jonase/eastwood "0.1.5"]
                  [lein-cloverage "1.0.2"]
                  [lein-exec "0.3.4"]
                  [lein-ancient "0.5.5"]
                  [lein-kibit "0.0.8"]]
        :dependencies [[pjstadig/humane-test-output "0.6.0"]]
        :injections [(require 'pjstadig.humane-test-output)
                     (pjstadig.humane-test-output/activate!)]}}
