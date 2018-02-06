package main

import (
	"flag"
	"github.com/golang/glog"
)

var (
	cfg     string
	version bool
)

func init() {
	flag.StringVar(&cfg, "config", "cfg.json", "config file")
	flag.BoolVar(&version, "version", false, "show version")
}

var (
	buildstamp string
	githash    string
)

func showVersion() {
	glog.Info("Git Commit Hash: %v\tBuild Time:%v\n", githash, buildstamp)
}


func main() {
	flag.Parse()

	showVersion()
}
