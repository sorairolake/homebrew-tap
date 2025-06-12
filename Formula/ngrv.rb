# SPDX-FileCopyrightText: 2025 Shun Sakai
#
# SPDX-License-Identifier: CC0-1.0

class Ngrv < Formula
  desc "Terminal-based pipe viewer similar to `pv(1)`"
  homepage "https://github.com/sorairolake/ngrv"
  url "https://github.com/sorairolake/ngrv/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "652a1d1210c56307d6f2263c9b4c0068ad3138436b115455a9feddeb0eb8bbc8"
  license "GPL-3.0-or-later"
  head "https://github.com/sorairolake/ngrv.git", branch: "develop"

  depends_on "asciidoctor" => :build
  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args

    out_dir = Dir["target/release/build/ngrv-*/out"].first
    man1.install Dir["#{out_dir}/*.1"]

    system "#{bin}/ngrv --generate-completion bash > ngrv.bash"
    system "#{bin}/ngrv --generate-completion fish > ngrv.fish"
    system "#{bin}/ngrv --generate-completion zsh > _ngrv"
    bash_completion.install "ngrv.bash"
    fish_completion.install "ngrv.fish"
    zsh_completion.install "_ngrv"
  end

  test do
    system "#{bin}/ngrv", "-V"
  end
end
