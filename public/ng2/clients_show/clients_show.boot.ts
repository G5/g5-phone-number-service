import {bootstrap} from 'angular2/platform/browser'
import {ClientsShowComponent} from './clients_show.component'
import {DataService} from './clients_show_data.service'

bootstrap(
    ClientsShowComponent,
    [
        DataService
    ]
);
