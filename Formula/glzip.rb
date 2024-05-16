# SPDX-FileCopyrightText: None
#
# SPDX-License-Identifier: CC0-1.0

class Glzip < Formula
  desc "Utility for reading and writing of lzip format compressed files"
  homepage "https://github.com/sorairolake/lzip-go"
  url "https://github.com/sorairolake/lzip-go/archive/refs/tags/v0.3.4.tar.gz"
  sha256 "63270aa1e4776206d374f6a2ef76a161d8dd82776286fb13e9676b6adaad55e1"
  license any_of: ["Apache-2.0", "MIT"]
  head "https://github.com/sorairolake/lzip-go.git", branch: "develop"

  depends_on "asciidoctor" => :build
  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"

    system "go", "build", *std_go_args(ldflags: "-s -w"), "./cmd/glzip"

    system "asciidoctor", "-b", "manpage", "docs/man/man1/glzip.1.adoc"
    man1.install "docs/man/man1/glzip.1"
  end

  test do
    system "#{bin}/glzip", "-version"
  end
end
