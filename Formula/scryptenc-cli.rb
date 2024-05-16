# SPDX-FileCopyrightText: None
#
# SPDX-License-Identifier: CC0-1.0

class ScryptencCli < Formula
  desc "Utility for encrypt and decrypt files"
  homepage "https://sorairolake.github.io/scryptenc-rs/"
  url "https://github.com/sorairolake/scryptenc-rs/archive/refs/tags/scryptenc-cli-v0.7.12.tar.gz"
  sha256 "e8e774a5a3fd2dcf5cceae70351bd50f18dd5b28bc97ce76be5a8fce5caa93c2"
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

    system "#{bin}/rscrypt --generate-completion bash > rscrypt.bash"
    system "#{bin}/rscrypt --generate-completion fish > rscrypt.fish"
    system "#{bin}/rscrypt --generate-completion zsh > _rscrypt"
    bash_completion.install "rscrypt.bash"
    fish_completion.install "rscrypt.fish"
    zsh_completion.install "_rscrypt"
  end

  test do
    system "#{bin}/rscrypt", "-V"
  end
end
