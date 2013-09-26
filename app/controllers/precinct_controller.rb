# encoding: utf-8 
class PrecinctController < ApplicationController
	def test
		data = 'LzlqLzRBQVFTa1pKUmdBQkFRQUFBUUFCQUFELzJ3QkRBQU1DQWdNQ0FnTURBd01FQXdNRUJRZ0ZCUVFFQlFvSEJ3WUlEQW9NREFzS0N3c05EaElRRFE0UkRnc0xFQllRRVJNVUZSVVZEQThYR0JZVUdCSVVGUlQvMndCREFRTUVCQVVFQlFrRkJRa1VEUXNORkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCVC93QUFSQ0FDV0FLQURBU0lBQWhFQkF4RUIvOFFBSHdBQUFRVUJBUUVCQVFFQUFBQUFBQUFBQUFFQ0F3UUZCZ2NJQ1FvTC84UUF0UkFBQWdFREF3SUVBd1VGQkFRQUFBRjlBUUlEQUFRUkJSSWhNVUVHRTFGaEJ5SnhGREtCa2FFSUkwS3h3UlZTMGZBa00ySnlnZ2tLRmhjWUdSb2xKaWNvS1NvME5UWTNPRGs2UTBSRlJrZElTVXBUVkZWV1YxaFpXbU5rWldabmFHbHFjM1IxZG5kNGVYcURoSVdHaDRpSmlwS1RsSldXbDVpWm1xS2pwS1dtcDZpcHFyS3p0TFcydDdpNXVzTER4TVhHeDhqSnl0TFQxTlhXMTlqWjJ1SGk0K1RsNXVmbzZlcng4dlAwOWZiMytQbjYvOFFBSHdFQUF3RUJBUUVCQVFFQkFRQUFBQUFBQUFFQ0F3UUZCZ2NJQ1FvTC84UUF0UkVBQWdFQ0JBUURCQWNGQkFRQUFRSjNBQUVDQXhFRUJTRXhCaEpCVVFkaGNSTWlNb0VJRkVLUm9iSEJDU016VXZBVlluTFJDaFlrTk9FbDhSY1lHUm9tSnlncEtqVTJOemc1T2tORVJVWkhTRWxLVTFSVlZsZFlXVnBqWkdWbVoyaHBhbk4wZFhaM2VIbDZnb09FaFlhSGlJbUtrcE9VbFphWG1KbWFvcU9rcGFhbnFLbXFzck8wdGJhM3VMbTZ3c1BFeGNiSHlNbkswdFBVMWRiWDJObmE0dVBrNWVibjZPbnE4dlAwOWZiMytQbjYvOW9BREFNQkFBSVJBeEVBUHdEOVVLS0tLQUNpaWlnQW9vb29BQ01pb25sU0JOMGpiRi8ycTRuNHAvRjN3NThIUERVdXRlSXJ4WVlWK1dLRlA5YkszOTFWcjg2dmpaKzFoOFFmMmlicDlEOEwyZDNvbmgvL0FKOTdGLzNzL3dEMTFiLzJTc1pWWVErTWNWS2I1WW4zUDhRUDJ2UGhkOE41M3RkVjhTd1hONmk3bXQ3SC9TSC9BUEhhODZ0ditDa1h3bm1sZFpZOWJ0bDNmSzcyYS9OLzQvWHdRbjdObmpGNFB0TTluOS8vQUpZL2ZlcVNmQVR4WWtUenRwRWlSSi9IWEw5ZG9mekhUOVJ4ZjhwK3JmdzQvYVkrSEh4WGxXMjhQK0pMWjcwbmFMSzZQa1ROL3VvLzNxOVdPYS9GTzIrQnZpK0ZJcnlEVDd1MlJmNDNYWlgwSjhGUDJ5dkYvd0FITGlMdy93Q1BvN3JYdERUNUlyaHYrUHFEL2RadnYvN3JWdlRyMHAvREl5blJxMHZpaWZwVFJYTitEZkhHamZFTHcvYjYzNGYxQ0hVdFBuWDVKWW4vQVBIVy91dFhTVjBtUVVVVVVBRkZGRDBBRkZGRkFCUlJSUUFVZndVVVVBRllIalB4YlkrQi9ER3BhL3FjbXl5c0lIbmwvd0NBMXYxOG1mOEFCUUh4ZlBwL3crMGp3clpueTVkZXV2M216L25sSHovOFRVVG55SzQwcm55Vk5yV3VmdGEvR1c3MVhXWjUwOFAyN2Z1TFRkOGtFWDl5dnFEd3I0TTBydzlheFcybVdNVnRFdjhBY1d2TlBnUDRNZzhLNkNubGY2MmY3ejE3eHBVS3d1djNxL1BNZmk1VjZ2Skg0VDd6THNGQ2pTNTUvRWFGbjRlV2FML1ZmSlduL3dBSXJBbi9BQ3lXdERUWnZ1YlYrU3R2K0pQbHFLZEZHOVN1NEhIM1BoaUoxZjhBY0xYbi9qRDRWNkQ0aGllUFU5UGdtUnY5bXZhcjhmdXZsV3VTMWlGWG9xTjBmZ0ZIbHJmR2ZMRnRyV3Qvc2RlTmJmV2RCbGx2L0JXcVB0dnRLbGJwL3dEWi93QzNYNkNlQmZHbWxmRVh3cnB2aUxTSlBOMC9VSXZOaGRsK2JGZkpYeFg4SHhlTGZEVnhwa3Z6cDk5YTB2MkUvRTF4NGRtOFFmRHErTFNMYTQxTFR5Lzl4dmxsWC92cmIvMzFYMWVXNDMyOGVXWHhIeDJZWWIyRlgzZmhQc2FpaWl2ZVBOQ2lpaWdBb29vb0FLS0tLQUNpaWhLQUN2akw5dSt3KzArTGZBN2J2dUxQL3dDeVY5bE4wZXZpZjlzTFcvOEFoSi9FdmhXZTBnYjdKWVh6V1U3L0FPMHpwWG40MnBHRkk2c0xUbE9mdW1WRHJGdDRNOFAyOHQwM2tvaTF5V3BmSHZ4RytzN2RCOFAzTi9icjhuK3ErL1hwVi80UGkxNndpYWZiOW5nK2R0OWMxRDhXbThBYUpxdW9lSHZDYlg5cHBjcUpjdW55TzMrMy9lYXZoc05HbktmdlI1ajcyWHRlVDNUcGZBbjdUOW5EZVJhZjRxMEhWTkV1MitUZTlxMnl2by9Tcm14MWkxVzZ0cEZlSi80MHJ4andsOFJYOGRhWnBGNXEraGZaNHRXaTN4STYrYThIei9Kdi91MTNIaGJWWTRXdW9JbC8xWDkydlQ5cEdFdVhsT0NXSHFUanpGYjRvL0Z6dy84QURTQkcxRmJtWm4rNzluaTMxODRlSi8yc1d2THIvaVZhSGQvWlArZXR4RjhsZS82M3FHbTIyaVM2cGVXcTNrc3N2bExGdDMvUFhtRnQ4ZnRQMUx4SHFIZ3lMd3ZkM09vV0N1ODhLV3E3RVZVKy93RGZvaktOWDdJUnB6aDhNaXJvUHhSc2ZHSGxSTHV0cjE0dDdXODFYL2dwSC9ZMzdTZWp4THo5c3M3cUwvZ1BsYi8vQUdTc3JSUERlZytOcnFMWHRCaVcyZUNYN2lWMFhnaDRkSS9hQTBDK3VGayt5MmRoY08wcXI5MTIvZGYrejFPQTVZWW4zVG56S2xLVkkreWFLWnZwOWZjSHg0VVVVVUFGRkZGQUIvSFJSUi9IUUFKUlJSL0JRQkd5a2dmU3ZrWDQ4ZUY1Yks1MW0vZi9BSTlWdkxlWC93QWVTdnI2dkF2MmpORGl1QlpTczRTRnY5WW16ZDV0ZVBtZFBubzh4N09WVk9TcTQvekhFK0c3ejdURjVIL0xKcTdEU3ZDRm41cXllUkc2dC9lV3VGOE56TGJYQ2YzSzlmOEFERCtkRW5GZko0S25GelB0SzlUa3BjeG42bFpwYlFNMFM3SFZmKythNTd3bGN4U1NYZmtMdlRkL3JhNlQ0bHd5L3dEQ1B5cmJJNzdtWHpVVDc3TC9BQlZ4UGhmeFBZNmF6UUMwdVJidC9xbjhxdW10R1B0aWNQTG5vY3h2ZUd3azExZTIzeXZGSzI1a3JYdXZCR2tPclNMWXdwSzY3V2RGK1pxNTN3N1BCZCtMUFB0bGtobVpQM3F2L2RyMGFhMlRidWF0Nk5QM1RreEV1V29lZEo0ZXRmREVWeDlqZ1dGSmZ2YktvZUMvRGt1dGVQSUxwZjhBajMzS2tuL0FkN1YwUGllWmZLZFYrL1YvNEQySG1hbnExNDB1OUZWRTJmM2Y4N2FNTENNc1RZeHhsYmt3OXoyd2ZkRkZGRmZhSHdvVVVVVUFGRkZGQUJSUlJRQVVVVVVBSU9sYzM0eThFMlBqRzFXTzczS3lmZFpLNldrM1ZuS0VaeDVaRnhsS0V1YUo4bXphUDlnMWU5czIvd0NXRXV5dlJmQjcvd0NqL2VybFBqRC9BTVUzOFI5ek5zdDd4Zk5yVThNYTNCTHRaVytTdnoyci9zbUlsRSs5cDFQckdHaklsK0pYanpUL0FBM0FuMnVlS0gvZnJ5UzIrTk9rUC94NTMwOXQ4MjluOHI3MWVqK01mQUdoK003dUs1dWJOYm1WUCtXdjl5dWNuK0VuMlR5bHRKbEVPNzdubGZkcUl5NTZuTkk5L0FmVllVK1NxUWFKOFYvRDEvZitWYlhuazNEL0FQUFg1TjFldHBxNGswenpmTTM3bC9ncnorSDRTNlZjeEo5dWdndkgrLzhBdlZyZWVhMjByUm5nczR2SlJQa1ZQN3RIdGZaSERpMVFuUDhBZEdUcmQ1SzZTLzdkZXRmQ3Z3bERvT2tKcUc2VDdWZXhLOG9mN3ExNDFZeUhYOWFzTkxoZGhKY3liU1ZyNmZ0cmRMZTNTS1A1VlZkcTE3MlRVK2JtcXlQazgyci9BUExxSlBSUlJYMVo4MEZGRkZBQi9IUWxIOGRGQUJSUlJRQVVVanVxRDV2dTF6K3MrUHZEbmg2SjVkVDFxeHM0bC9qbG5Xb0E2R2l2SWZFMzdWWHd5OE1XVFR6K0pyUzZYKzdhdHZyNXYrSW4vQlJoYnhMaXo4R2FOOG4zZnQyb04vN0pWdzkvNFRLcFVqUytJNnY5cDd4UGJlSlBpSExvTmxLcWFocGRtc3JQdS92ZndmNS92MTVMby94WHZ0SGw4aWVKdDhYeVNwWGtud3I4ZjNQaVQ0cFh0OXJWNDE1cUYrcitiSy84VmZRR3QrQTRwb0V1YlpkKzc3MysxWHcrZDBQWlZ1ZWZ3eVB0Y2txckVZZTBmaVIzSGdiNHdhZHF0cSsrZFVmK0pLNjEvaVhwRm5hbzBzNjcvd0RiYXZtRFV2QUV2bnBQQXJJNmY4QWVyK20rQTNTTHpKNEdtZjhBNmF0WGlSclJwUjkxbnZjdjh4OUI2cjhTOUZ0b04wVjlGdjhBNHZtcnpMWHZpNy9hVXZsV3lmNkovZjhBNzFlZVA0TVpMcjkxYWZNMysxWFc2SjRTZ2gyZmJ2OEF4K3RITlZkam45Nk1qcVBoOThSNHZDbmpqdzFxR29vcUpmM3lhYkZ2L2g4MzVkOWZhNll4eFg0L2ZIdng1L2FYakszdHJOdjlIMHRmbDJmM3E2endKKzJ4OFNmQWl3TC9BR3l1dTJFZnlHMTFWZk1QL2ZmMzYvUTh0d2M2V0hqemJuNTFtR09qVXhVdVg0VDlWaWNVNE5sYzE4Z2VCdjhBZ29uNFQxNjE4dlhOR3ZkSzFQSEVjUjgyS1Q2R3ZUWlAycS9EMmlYOEZwNG4wald2Q3pUcHZpbHZyWGRFeS9WYTdKZTdMbE00KzlIbit5ZTUwVnpQaHI0aGVHdkdNSWZROWNzTlNEZHJlNFV2L3dCODEwMzhGQllVVVVVQWNIOFFQaS80WitGdGkxenIycFJRTi9EQkg4MHJWODRlUC8yMXRjbThQUzZ2NFYwR08yMGZ6ZnM2NmpxTXEvTy8reXRmS1hqUFh0WDhUK0Q5SzFYV3ZGVnBxVng1N0pGcDd0dnVJbC81NnY4QS9aMTVWcVhpMktGVWc4Mlc4ZGZ1N0crUmE1ZWFwTXIyTXBhcjRmdVgzbnRmakQ5cG54LzQyMy9idkVkeWlmOEFQSzAvZEovNDdYbktlTUowMVMzdnJuL2lhK1ZLanRGZk16cEwvc1BYQlA0bnVadjlWRXFKL3QvUFdmYzZycUUyL3dEMHh0bit4OGxiK3dsTW1Lb1VmaWwrcDZiOFkvaTFjL0VLL3RKWjdHeDByeW92czhWcFl4YkVWSzg5czcvZTd3VmovZlQ1dnY4QSszVHB0ME02Uy9Oc3JxbzBmWXg1WW5Iaks4SzB2ZE52U3RWbjBUVzdlNWdsMlNvMjlYcjc2K0QvQUkvdHZFUGh5MGx1Vi9kU3I5Lys3WDU1ZWR2Mk4vSFh1SDdPWHhSYnd4cmlhVmVTci9aOSszOGYvTEtXdXlPRXcrWVIrcjRnOC82NWlNdmw3YkRuM0JOb050TTNtcjVUeFA4QXgxZFR3OUVpL2RyenJVdkhtbGVHSCtiV3JUVGJqYjV2bFN6L0FIditBVlVzUDJrTEdaRWxsdnRMaHQvK20wdnovd0RmRmZJNHZnNnZTbis2bHpIMTJFNHdvVllmdlk4cDZoL3dpdHROL0Q4bjhWZUsvRy94YnBuaDdTN3VXQnZPUzErOS93Qk5XL3VWcFEvRTdUL2lGZVh0dEY0ajNwRXU5cmUzK1Q1SytaZjJoUEg5dHF1cmYyRHBYejJWcTM3K2IrKzM5eXZYeTNoYU9CajlieFV2KzNUeDhmeE5MR2Y3TGhQbkk4aTFLL24xVzlsbm5iZmNUeTc1WG91Ynp5WWtpcUYvaytiL0FNY3FxNy9hVytiN2kxNi9vZVFXa3Y1Yk9kSjErZFA3bGVnVGZGVFV2RU5oWldPb2ExYzNNVnF1eUMzdTVmOEFWZjdsZVh2TjUwcm9uM0ttMmZPbGN0U2p6UzVqMGFXSjVhZnNweFBXTk44VHoyYzZTeHlzanA5MTBiWlh2WHdmL2FZOGE2SnJOcFovOEpSRjlpYi9BSlphOHpQYi93RGZmM2xyNHloZVZIL2NTc24rNDFiRmg0aDFDd2RQbSsweGYzSHJHVktvYWZ1Si9ETGxQMXUrSFg3VVBoWHhqZW5TOVF1RjBMWFZsOHByZTRrM3hTdHUvd0NXVXYzU3RlMkpKdjhBbS9ocjhhdmgxOFR0STBmWHJlNTFPQzUyUmZkUzN1dnM3cTM5OUhyM1Q0Yy90VCtMdkRYaWJiQmZTYXZwMTFJcUN6MUJQdmYzZnUvZGIvZHJHUE5LWEthempLakhtWjhjMytwVDZrejdtMlJmODhVclA4bjVYK1dtZmIxVGV0UFI5K3l2VmpUakE4dXBYcTFkSkRFK1QrR2pmc2ZkUS95UzBUZmQvaS8zNlptTS9pUnYvSEt2WExxNklzdFViWk44OFMxb1hpYjErWnRuKy9RUnpGSjRmSmI1V3JWczV2SmFKbWxWS3hibTUySS9rTFVPemVpTTMzNlh3U0xsSG5QUTlTOFEzMnBTcHFGNWMvYkgrV0p2OTMrQ3REN1p2c1B0UDhGZWRXZDU5bWxSVys0L3lNbGVpNlBEcStnK0hMTFh2N0Z1Ym5USUxyZkZmVFJmNk8vOXoveCt1eU5hVXBlK2VWWHcvTDhKc1BxUy9EM1FiaTVubFpQRnQ2dmxSVy8vQUQ1eGY3ZisxWGxpWGtGNXYrYjk3L0ZSNGgxdTUxNi91TDY4bmE1dTdodDd1LzhBSFdVa0xKTDV2OGRGZXY3WDNZL0NkT0dvUXBSL3ZGdDV0Ny83RkxjdnN0ZmxwRWZ6djkvK0pLZE5EdjhBS1d1UGxPb2l0b2RpZjdkUGY1RWVuUDhBK09WRjkrcktKYlpObFdVLzJhWWo3RnBtK3BNaXdpYjErYjc5Yk9sYWxlYVZkUk5ZenNuemZML3NOL3NWazJ6NzlsV0libnlXZHY3dExsakw0aS9iVlY3c1pIT2ZZOThxTi9IVnY3bnk3dm5wdnplYW03N2xSdjhBZStYNUtzQjcvUDhBTlFqNzFwNmZPdE1UNUhxUURlME1xTXJiSC8yS2lmZE5MdVp0NzFZU1BlcjB4SWZtMjBBSGs3L21xVkxiOTFSdjJSVmJzL3VWUUdlOE5lcTNPcXdQOENkTXRWOFJzOXcrcHRFMmcvM1YyYi90RmVaVFBzbHFXSC9WSjgxV1pNZzhwS2RzKzVRai9OL3NWTC90VkJvVW50dGsvbXhWWWQ5N1VPbi9BSDNUTi84QXdPamxHUk85Q2ZlLzlrcCt3VUowb0Z6RTN5N3FaTDk2a3FMZjg2VUJFMExiNUZlcWp6ZnVrLzI2Zk0reUIvNEtyelBzMlVFaE1UNjB5aWlwQW1UL0FGZE1laWlsRUJ5RTVxYlpSUlZsakhYZkU5V0xiNVlxS0traVh3bGViNW1xZUZ2M1NVVVZRcEZVU2hmNGF0cjh5N3FLS0JqWmlmV29ZVTNzOUZGQUJUdWZXaWlpSW9qVysvVFUvd0JiUlJRTUxuL1dvdFFTdHZPVC9mb29vRkUvLzlrQQ=='
		render json: {data: data}
	end

	def fetch_precinct
		territory = PrecinctTerritory.where(street: params[:street], house: params[:house]).first
		if territory
			precinct = territory.precinct
		else
			precinct = nil
		end
		render json: precinct
	end

	def search_by_name
		@precincts = Precinct.where("name like '#{params[:search_request]}%' or surname like '#{params[:search_request]}%' or middlename like '#{params[:search_request]}%'")
		render json: @precincts
	end

	def search_by_street
		@streets = PrecinctTerritory.where("street like '#{params[:search_request]}%'")
		render json: @streets
	end

	def create_precinct
		Precinct.create!(params[:precinct])
		render json: {status: "success"}
	end

	def create_territory
		PrecinctTerritory.create!(params[:precinct_territory])
		render json: {status: "success"}
	end
end