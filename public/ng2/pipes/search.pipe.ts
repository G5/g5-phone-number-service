import {Pipe, PipeTransform} from 'angular2/core';

/**
 * This pipe will filter out any items that do not coorespond with the search input
 */
@Pipe({ name: 'search' })
export class SearchPipe implements PipeTransform{
    transform(value, args){
        let search:string = args[0]? args[0].toLowerCase():null;
        let result = value;

        if(search){
            result = [];
            for(let row of value) {
                for (let property in row){
                    let propertyValue: string = row[property];
                    if(propertyValue.toLowerCase().indexOf(search) >= 0){
                        result.push(row);
                        break;
                    }
                }
            }
        }

        return result;
    }
}
