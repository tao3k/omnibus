let Tf = import "../../../../.data/tf-ncl/hello-tf/schema.ncl" in
let config = import "./config.ncl" in

config | Tf.Config
