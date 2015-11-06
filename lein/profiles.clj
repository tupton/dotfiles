{:user {:plugins [[jonase/eastwood "0.2.1"]
                  [lein-cloverage "1.0.6"]
                  [lein-exec "0.3.5"]
                  [lein-ancient "0.6.7"]
                  [lein-kibit "0.1.2"]
                  [cider/cider-nrepl "0.9.1"]]
        :dependencies [[pjstadig/humane-test-output "0.7.0"]
                       [jonase/eastwood "0.2.1" :exclusions [org.clojure/clojure]]]
        :injections [(require 'pjstadig.humane-test-output)
                     (pjstadig.humane-test-output/activate!)]}
        :eastwood {:exclude-linters [:unlimited-use
                                     :def-in-def
                                     :misplaced-docstrings
                                     :suspicious-test
                                     :suspicious-expression
                                     :unused-ret-vals
                                     :wrong-arity
                                     :wrong-ns-form
                                     :constant-test
                                     :local-shadows-var
                                     :deprecations
                                     :redefd-vars
                                     :wrong-tag]}}
