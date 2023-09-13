
local config = {
    cmd = {
        "/home/vince/apps/packages/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/bin/jdtls",

        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-Xmx1g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',

        "-jar", "/home/vince/apps/packages/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/plugins/org.eclipse.equinox.launcher_1.6.500.v20230717-2134.jar",

        "-configuration", "/home/vince/apps/packages/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/config_linux",
    },
    root_dir = vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw'}, { upward = true })[1]),
    filetypes = { "java" }
}

require("jdtls").start_or_attach(config)
