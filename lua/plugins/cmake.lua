-- ~/.config/nvim/lua/plugins/cmake.lua
return {
    "Civitasv/cmake-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    ft = { "cmake" },
    cmd = { "CMakeGenerate", "CMakeBuild", "CMakeRun", "CMakeDebug" },
    opts = {
        cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1" },
        cmake_build_directory = "build",
    },
}
