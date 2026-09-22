// OttPlayer's binary was compiled against Google IMA, and a binary target cannot
// declare dependencies. This target declares them instead (see Package.swift);
// the package manager builds a target only from at least one source file, and
// this is that file. It holds no code.
