package main

import (
	"flag"
	"github.com/golang/glog"
)

var (
	buildstamp string
	githash    string
)

var (
	cfg     string
	version bool
)

func showVersion() {
	glog.Infof("Git Commit Hash: %v\tBuild Time:%v\n", githash, buildstamp)
}

func init() {
	flag.StringVar(&cfg, "config", "cfg.json", "config file")
	flag.BoolVar(&version, "version", false, "show version")
}

func main() {
	flag.Parse()

	showVersion()
}
