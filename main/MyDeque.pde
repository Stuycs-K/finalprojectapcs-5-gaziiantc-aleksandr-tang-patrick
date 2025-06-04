import java.lang.StringBuilder;
import java.util.Arrays;
import java.util.NoSuchElementException;

class MyDeque<E>{
    private E[] data;
    private int size;
    private int start, end;

    public MyDeque(){
        this(10);
    }

    public MyDeque(int initialCapacity){
        @SuppressWarnings("unchecked")
        E[] d = (E[])new Object[initialCapacity];
        this.data = d; this.size = 0;
        this.start = this.data.length/2; this.end = this.data.length/2;
    }

    /**return the current number of values in the deque*/
    public int size(){

		return size;
    }
    public String[] debug1() {
		return new String[]{"Start: " + start, "End: " + end, "Size: " + size, "Functional Size: " + size(), "Wrapped start: " + wrap(start, size), "Wrapped end: " + wrap(end, size)};
    }
    public E[] debug2(){
        return data;
    }
    private int wrap(int n, int d){
        if(d == 0){
            return n;
        }
        if(n<0) {
            while (n < 0) {
                n += d;
            }
            return n;
        }else{
            return n%d;
        }
    }
    private E getWrapped(int index){  //wrapped as in it wraps around
        return data[wrap(index, data.length)];
    }
    private void addWrapped(int p, E val, E[] arr){
        arr[wrap(p, arr.length)] = val;
    }


    /**Format is comma+space separated values e.g. "[a, b, c, d]" or just "[]" */
    public String toString(){
        if(this.data.length == 0){return "[]";}
        if(this.data.length == 1){
            if(size()==1) {
                return "[" + this.data[0].toString() + "]";
            }else{
                return "[]";
            }
        }
        StringBuilder out = new StringBuilder(data.length);
        out.append("[");
        //System.out.println("New loop " + start);
        for (int i = start; i < end; i++) { //end is exclusive
            //System.out.println(i + " < " + end);
            //System.out.println(out + " " + i + " " + Arrays.toString(debug2()) + " " + Arrays.toString(debug1()) + " " +  this.getWrapped(i));
            if(this.getWrapped(i)!=null) {
                out.append(this.getWrapped(i).toString());
                out.append(", ");
            }
        }
        //System.out.println(out.toString());
        while(out.charAt(out.length()-1) == ',' || out.charAt(out.length()-1) == ' '){
            out.deleteCharAt(out.length()-1);
        }
        out.append("]");
		//System.out.println("" + out);
        return "" + out;
    }

    /**Double the capacity of the deque, copying the old values over in the correct order.*/
    private void resize(){
        @SuppressWarnings("unchecked")
        E[] d = (E[]) new Object[data.length * 2 + 1];
        if(this.data.length > 1){
            int pointer = (data.length*2+1) / 2;
			for (int i = start; i < end; i++) { //end is exclusive
				this.addWrapped(pointer++, this.getWrapped(i), d);
				//System.out.println("Adding " + this.getWrapped(i) + " at i " + i);
			}
            this.start = (data.length*2+1) / 2;
            this.end = pointer;
        }else if(this.data.length == 1){
			d[0] = this.data[0];
            this.start = 0; this.end = 1;
		}
        this.data = d;
    }

    /**Add an element to the first position of the deque, resize if needed.*/
    public void addFirst(E element){
        if(element == null){
            throw new NullPointerException("Element is null");
        }
        this.size++;
        if(this.size > this.data.length){
            resize(); 
		}
		this.start--;
        addWrapped(this.start, element, this.data);

    }

    /**Add an element to the last position of the deque, resize if needed.*/
    public void addLast(E element){
        if(element == null){
            throw new NullPointerException("Element is null");
        }
        this.size++;
        if(this.size > this.data.length){
            resize();
        }
        addWrapped(this.end, element, this.data);
        this.end++;
    }

    /**Remove and then return the first element*/
    public E removeFirst(){
		if(this.size == 0 || this.end-this.start == 0 || size() == 0){throw new NoSuchElementException("Empty Deque");}
        E out = getWrapped(this.start++);
        //if(this.end < this.start){
        //    this.end = this.start; //yeah
        //}
		this.size--;
        return out;
    }

    /**Remove and then return the last element*/
    public E removeLast() {
		if(this.size == 0 || this.end-this.start == 0 || size() == 0){throw new NoSuchElementException("Empty Deque");}
        E out = getWrapped(this.end--);
        //if(this.end < this.start){
        //    this.end = this.start;
        //}
		this.size--;
        return out;
    }

    /**Return but do not remove the first element*/
    public E getFirst(){
        if(this.size == 0 || this.end-this.start == 0 || size() == 0){throw new NoSuchElementException("Empty Deque");}
        return getWrapped(this.start);
    }

    /**Return but do not remove the last element*/
    public E getLast(){
        if(this.size == 0 || this.end-this.start == 0 || size() == 0){throw new NoSuchElementException("Empty Deque");}
        return getWrapped(this.end-1);
    }
}
