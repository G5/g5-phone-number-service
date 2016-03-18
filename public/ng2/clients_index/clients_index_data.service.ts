import {Injectable} from 'angular2/core';

@Injectable()
export class DataService{
    clients() {
        return (window as any).clients
    }
}
