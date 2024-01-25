defmodule Auction.Password do
  import Pbkdf2

  def hash(pwd) do
    hash_pwd_salt(pwd)
  end

  def verify_with_hash(pwd, hash) do
    verify_pass(pwd, hash)
  end

  def dummy_verify() do
    no_user_verify()
  end
end
