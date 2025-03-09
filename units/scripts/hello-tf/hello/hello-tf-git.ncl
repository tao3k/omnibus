let Tf = import "../../.data/tf-ncl/hello-tf-git/schema.ncl" in
let config = import "./config.ncl" in

config | Tf.Config
