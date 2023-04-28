package com.bbbox.board.model.vo;

public class Search {
//searchFilter,region,partType,insuranceType,keyword
	private String searchFilter;
	private String region;
	private int partType;
	private String insuranceType;
	private String keyword;
	private int categoryNo;
	
	public Search() {
		super();
	}

	

	public Search(String searchFilter, String region, int partType, String insuranceType, String keyword,
			int categoryNo) {
		super();
		this.searchFilter = searchFilter;
		this.region = region;
		this.partType = partType;
		this.insuranceType = insuranceType;
		this.keyword = keyword;
		this.categoryNo = categoryNo;
	}



	public String getSearchFilter() {
		return searchFilter;
	}

	public void setSearchFilter(String searchFilter) {
		this.searchFilter = searchFilter;
	}

	public String getRegion() {
		return region;
	}

	public void setRegion(String region) {
		this.region = region;
	}

	public int getPartType() {
		return partType;
	}

	public void setPartType(int partType) {
		this.partType = partType;
	}

	public String getInsuranceType() {
		return insuranceType;
	}

	public void setInsuranceType(String insuranceType) {
		this.insuranceType = insuranceType;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public int getCategoryNo() {
		return categoryNo;
	}

	public void setCategoryNo(int categoryNo) {
		this.categoryNo = categoryNo;
	}

	@Override
	public String toString() {
		return "Search [searchFilter=" + searchFilter + ", region=" + region + ", partType=" + partType
				+ ", insuranceType=" + insuranceType + ", keyword=" + keyword + ", categoryNo=" + categoryNo + "]";
	}

	
	
	
	
}
