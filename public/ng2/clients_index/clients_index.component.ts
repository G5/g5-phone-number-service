import {Component}              from 'angular2/core'
import {DataService}            from './clients_index_data.service'
import {SearchPipe}     from '../pipes/search.pipe'

@Component({
    selector: 'clients-index',
    templateUrl: '/ng2/clients_index/clients_index.component.template',
    pipes: [SearchPipe]
})
export class ClientsIndexComponent{
    constructor(private _dataService: DataService){}
    clients = [];
    search: string;
    ngOnInit(){
        this.clients = this._dataService.clients();
    }

    link_to(client){
        return `/clients/${client.urn}`;
    }
}
