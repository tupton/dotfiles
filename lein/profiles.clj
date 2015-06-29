{:user {:plugins [[jonase/eastwood "0.2.1"]
                  [lein-cloverage "1.0.6"]
                  [lein-exec "0.3.5"]
                  [lein-ancient "0.6.7"]
                  [lein-kibit "0.1.2"]]
        :dependencies [[pjstadig/humane-test-output "0.7.0"]]
        :injections [(require 'pjstadig.humane-test-output)
                     (pjstadig.humane-test-output/activate!)]}}
