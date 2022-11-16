import * as chai from 'chai';
import chaiAsPromised from 'chai-as-promised';
import { describe, it } from 'mocha';
const { expect } = chai;
chai.use(chaiAsPromised);

describe('Just testing', () => {
    context('Dingdong', () => {
        beforeEach(() => {
            // runs before all tests in this block
            console.log('before');
        });
    });
});
