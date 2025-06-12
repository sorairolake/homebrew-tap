# SPDX-FileCopyrightText: 2024 Shun Sakai
#
# SPDX-License-Identifier: CC0-1.0

class ScryptencCli < Formula
  desc "Utility for encrypt and decrypt files"
  homepage "https://sorairolake.github.io/scryptenc-rs/"
  url "https://github.com/sorairolake/scryptenc-rs/archive/refs/tags/scryptenc-cli-v0.8.0.tar.gz"
  sha256 "636e9870985894beff16c5a03cf3b5cfa51fa430a03a8999b952099f13c310c1"
  license "GPL-3.0-or-later"
  head "https://github.com/sorairolake/scryptenc-rs.git", branch: "develop"

  depends_on "asciidoctor" => :build
  depends_on "rust" => :build

  def install
    ENV["CARGO_PROFILE_RELEASE_LTO"] = "true"
    ENV["CARGO_PROFILE_RELEASE_PANIC"] = "abort"

    system "cargo", "install", *std_cargo_args(path: "crates/cli")

    out_dir = Dir["target/release/build/scryptenc-cli-*/out"].first
    man1.install Dir["#{out_dir}/*.1"]

    system "#{bin}/rscrypt completion bash > rscrypt.bash"
    system "#{bin}/rscrypt completion fish > rscrypt.fish"
    system "#{bin}/rscrypt completion zsh > _rscrypt"
    bash_completion.install "rscrypt.bash"
    fish_completion.install "rscrypt.fish"
    zsh_completion.install "_rscrypt"
  end

  test do
    system "#{bin}/rscrypt", "-V"
  end
end
