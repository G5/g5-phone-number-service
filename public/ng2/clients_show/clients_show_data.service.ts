import {Injectable} from 'angular2/core';

@Injectable()
export class DataService{
    locations() {
        return (window as any).locations;
    }
}
