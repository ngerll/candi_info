package com;

import java.util.ArrayList;
import java.util.Random;

public class Candidate {
	
	public int randomID(int i,ArrayList<Integer> al){	
		int save = 0;
		ArrayList<Integer> all_list = new ArrayList<Integer>();
		
		for(int all_i = 1; all_i<= i; all_i++){
			all_list.add(all_i);
		}
		
		for(int order_i = 0;order_i<al.size();order_i++){
			all_list.remove(al.get(order_i));
		}
		
		if(all_list.size() > 0){
			Random r = new Random();
			save = all_list.get(r.nextInt(all_list.size()));
		}else{
			save = 0;
		}
		
		return save;
	}

}
