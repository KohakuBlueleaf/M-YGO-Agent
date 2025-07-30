add_rules("mode.debug", "mode.release")

add_repositories("my-repo repo")

add_requires(
    "ygopro-core 0.0.2", "edopro-core 0.0.2", "pybind11 2.13.*", "fmt 10.2.*", "glog 0.6.0",
    "sqlite3 3.43.0+200", "concurrentqueue 1.0.4", "unordered_dense 4.4.*",
    "sqlitecpp 3.2.1")


target("ygopro0_ygoenv")
    add_rules("python.library")
    add_files("src/ygoenv/ygopro0/*.cpp")
    add_packages("pybind11", "fmt", "glog", "concurrentqueue", "sqlitecpp", "unordered_dense", "ygopro-core")
    set_languages("c++17")
    if is_mode("release") then
        set_policy("build.optimization.lto", true)
        add_cxxflags("-march=native")
    end
    add_includedirs("ygoenv")
    add_ldflags("-Wl,--no-undefined") -- From linkoptions for linux

    after_build(function (target)
        local install_target = "$(projectdir)/src/ygoenv/ygopro0"
        os.cp(target:targetfile(), install_target)
        print("Copy target to " .. install_target)
    end)


target("ygopro_ygoenv")
    add_rules("python.library")
    add_files("src/ygoenv/ygopro/*.cpp")
    add_packages("pybind11", "fmt", "glog", "concurrentqueue", "sqlitecpp", "unordered_dense", "ygopro-core")
    set_languages("c++17")
    if is_mode("release") then
        set_policy("build.optimization.lto", true)
        add_cxxflags("-march=native")
    end
    add_includedirs("ygoenv")
    add_ldflags("-Wl,--no-undefined") -- From linkoptions for linux

    after_build(function (target)
        local install_target = "$(projectdir)/src/ygoenv/ygopro"
        os.cp(target:targetfile(), install_target)
        print("Copy target to " .. install_target)
    end)

target("edopro_ygoenv")
    add_rules("python.library")
    add_files("src/ygoenv/edopro/*.cpp")
    add_packages("pybind11", "fmt", "glog", "concurrentqueue", "sqlitecpp", "unordered_dense", "edopro-core")
    set_languages("c++17")
    if is_mode("release") then
        set_policy("build.optimization.lto", true)
        add_cxxflags("-march=native")
    end
    add_includedirs("ygoenv")
    add_ldflags("-Wl,--no-undefined") -- From linkoptions for linux

    after_build(function (target)
        local install_target = "$(projectdir)/src/ygoenv/edopro"
        os.cp(target:targetfile(), install_target)
        print("Copy target to " .. install_target)
    end)
