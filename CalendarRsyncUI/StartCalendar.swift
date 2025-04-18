//
//  StartCalendar.swift
//  Calendar
//
//  Created by Thomas Evensen on 29/03/2025.
//

import SwiftUI

struct StartCalendar: View {
    @State private var rsyncUIdata = RsyncUIconfigurations()
    @State private var scheduledata = ObservableScheduleData()
    @State private var futuredates = ObservableFutureSchedules()

    var body: some View {
        VStack {
            CalendarMonthView(rsyncUIdata: rsyncUIdata,
                              scheduledata: scheduledata,
                              futuredates: futuredates)
        }
        .task {
            // Set as standalone macos applicatiomn
            SharedReference.shared.standalonecalendar = false
            
            let catalognames = Homepath().getfullpathmacserialcatalogsasstringnames()
            rsyncUIdata.validprofiles = catalognames.map { catalog in
                ProfilesnamesRecord(catalog)
            }
            // Load calendardata from store
            scheduledata.scheduledata = await ActorReadSchedule()
                .readjsonfilecalendar(rsyncUIdata.validprofiles.map(\.profilename)) ?? []

            futuredates.scheduledata = scheduledata.scheduledata
            futuredates.recomputeschedules()
            // Only compute when loading data and if changes
            futuredates.setfirsscheduledate()
        }
    }
}
