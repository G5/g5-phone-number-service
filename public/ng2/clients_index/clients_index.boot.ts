import {bootstrap} from 'angular2/platform/browser'
import {ClientsIndexComponent} from './clients_index.component'
import {DataService} from './clients_index_data.service'

bootstrap(
    ClientsIndexComponent,
    [
        DataService
    ]
);
