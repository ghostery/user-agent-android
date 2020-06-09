package org.mozilla.fenix.crashes

import mozilla.components.lib.crash.Crash
import mozilla.components.lib.crash.service.CrashReporterService
import mozilla.components.support.base.crash.Breadcrumb

class DummyCrashReporter : CrashReporterService {
    override val id: String = "dummy"

    override val name: String = "dummy"

    override fun createCrashReportUrl(identifier: String): String? = null

    override fun report(throwable: Throwable, breadcrumbs: ArrayList<Breadcrumb>): String? = null

    override fun report(crash: Crash.NativeCodeCrash): String? = null

    override fun report(crash: Crash.UncaughtExceptionCrash): String? = null
}
