require "spec.lua.conftest"

local helpers = require "spec.lua.helpers"

describe("pyunit", function()
  before_each(function()
    helpers.before_each { run = false, runners = { python = "nvim-test.runners.pyunit" } }
  end)
  after_each(helpers.after_each)

  local filename = vim.fn.fnamemodify("spec/lua/test/fixtures/test.py", ":p")

  it("run suite", function()
    helpers.view(filename)
    vim.api.nvim_command "TestSuite"
    assert.are.equal("python -m unittest", vim.g.nvim_last)
  end)

  it("run file", function()
    helpers.view(filename)
    vim.api.nvim_command "TestFile"
    assert.are.equal("python -m unittest spec.lua.test.fixtures.test", vim.g.nvim_last)
  end)

  it("run nearest function", function()
    helpers.view(filename, 4)
    vim.api.nvim_command "TestNearest"
    assert.are.equal("python -m unittest spec.lua.test.fixtures.test.test_base", vim.g.nvim_last)
  end)

  it("run nearest method", function()
    helpers.view(filename, 13)
    vim.api.nvim_command "TestNearest"
    assert.are.equal(
      "python -m unittest spec.lua.test.fixtures.test.MyTest.test_method2",
      vim.g.nvim_last
    )
  end)

  it("run latest", function()
    helpers.view(filename)
    vim.api.nvim_command "TestFile"
    assert.are.equal("python -m unittest spec.lua.test.fixtures.test", vim.g.nvim_last)

    vim.api.nvim_command "TestLast"
    assert.are.equal("python -m unittest spec.lua.test.fixtures.test", vim.g.nvim_last)
  end)
end)
