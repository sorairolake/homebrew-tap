# SPDX-FileCopyrightText: 2024 Shun Sakai
#
# SPDX-License-Identifier: CC0-1.0

class AbcryptCli < Formula
  desc "Utility for encrypt and decrypt files"
  homepage "https://sorairolake.github.io/abcrypt/"
  url "https://github.com/sorairolake/abcrypt/archive/refs/tags/abcrypt-cli-v0.5.0.tar.gz"
  sha256 "b9f5d60a23f5b31048a5c84907af3096e3555d59db7012d5fb80c51f1ec8ecf6"
  license "GPL-3.0-or-later"
  head "https://github.com/sorairolake/abcrypt.git", branch: "develop"

  depends_on "asciidoctor" => :build
  depends_on "rust" => :build

  def install
    ENV["CARGO_PROFILE_RELEASE_LTO"] = "true"
    ENV["CARGO_PROFILE_RELEASE_PANIC"] = "abort"

    system "cargo", "install", *std_cargo_args(path: "crates/cli")

    out_dir = Dir["target/release/build/abcrypt-cli-*/out"].first
    man1.install Dir["#{out_dir}/*.1"]
    man5.install Dir["#{out_dir}/*.5"]

    system "#{bin}/abcrypt completion bash > abcrypt.bash"
    system "#{bin}/abcrypt completion fish > abcrypt.fish"
    system "#{bin}/abcrypt completion zsh > _abcrypt"
    bash_completion.install "abcrypt.bash"
    fish_completion.install "abcrypt.fish"
    zsh_completion.install "_abcrypt"
  end

  test do
    system "#{bin}/abcrypt", "-V"
  end
end
