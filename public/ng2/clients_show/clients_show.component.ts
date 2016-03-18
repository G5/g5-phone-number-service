import {Component}              from 'angular2/core'
import {DataService}            from './clients_show_data.service'
import {SearchPipe}             from '../pipes/search.pipe'

@Component({
    selector: 'clients-show',
    templateUrl: '/ng2/clients_show/clients_show.component.template',
    pipes: [SearchPipe]
})
export class ClientsShowComponent{
    constructor(private _dataService: DataService){}
    locations = [];
    search: string;
    ngOnInit(){
        this.locations = this._dataService.locations();
    }

    edit_link(location){
        return `/locations/${location.urn}/edit`;
    }
}
