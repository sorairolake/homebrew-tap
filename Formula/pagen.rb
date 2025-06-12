# SPDX-FileCopyrightText: 2024 Shun Sakai
#
# SPDX-License-Identifier: CC0-1.0

class Pagen < Formula
  desc "Generate pixel art from random numbers"
  homepage "https://github.com/sorairolake/pagen"
  url "https://github.com/sorairolake/pagen/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "bd144c3bced0118ba26047d9e26b7267585754aa82cf15edd3fc9e59c02a21e7"
  license "CC0-1.0"
  head "https://github.com/sorairolake/pagen.git", branch: "develop"

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"

    system "go", "build", *std_go_args(ldflags: "-s -w")
  end

  test do
    system "#{bin}/pagen", "-version"
  end
end
