package com.web.iami.controller;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.web.iami.domain.CommentDTO;
import com.web.iami.domain.FileDTO;
import com.web.iami.domain.MemberDTO;
import com.web.iami.domain.PortfolioDTO;
import com.web.iami.domain.ReCommentDTO;
import com.web.iami.domain.RestCommentDTO;
import com.web.iami.domain.RestPortfolio;
import com.web.iami.domain.RestReCommentDTO;
import com.web.iami.service.MemberService;
import com.web.iami.service.PortfolioService;
import com.web.iami.util.CommentValidator;
import com.web.iami.util.PortfolioValidator;
import com.web.iami.util.ReCommentValidator;

@RestController
@RequestMapping("/portfolio")
public class RestPortfolioController {

	@Inject
	private PortfolioService portfolioService;
	@Inject
	private MemberService memberService;
	
	// 포트폴리오 업로드
	@PostMapping("/writeOk")
	public String writeOk(PortfolioDTO dto, BindingResult result) {
		
		PortfolioValidator validation = new PortfolioValidator();
		if(validation.supports(dto.getClass())) {
			
			validation.validate(dto, result);
			
			if(result.hasErrors()) {
				return "Fail";
			} else {
				try {
					int count = portfolioService.insertPortfolio(dto);
					
					if(count == 1) {
						FileDTO files = new FileDTO();
						files.setPot_no(dto.getPot_no());
						for(int i=0; i<dto.getFiles().length; i++) {							
							files.setFile_name(dto.getFiles()[i]);
							portfolioService.insertPortfolioFiles(files);
						}
						return "Ok";
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		
		return "Fail";
	}
	
	// 포트폴리오 댓글 작성
	@PostMapping("/comment/write")
	public String commmentWrite(CommentDTO dto, BindingResult result) {
		
		CommentValidator validation = new CommentValidator();
		
		if(validation.supports(dto.getClass())) {
			
			validation.validate(dto, result);
			
			if(result.hasErrors()) {
				return "Fail";
			} else {
				try {
					int count = portfolioService.insertPortfolioComment(dto);
					if(count == 1) {
						return "Ok";
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		
		return "Fail";
	}
	
	// 포트폴리오 댓글 불러오기
	@PostMapping("/comment/list")
	public RestCommentDTO commentList(@RequestParam(value = "pot_no", defaultValue = "0") int pot_no,
			@RequestParam(value = "page", defaultValue = "1") int page,
			@RequestParam(value = "row", defaultValue = "10") int row) {
		
		RestCommentDTO dto = new RestCommentDTO();
		
		if(pot_no == 0) {
			dto.setStatus("Fail");
			return dto;
		} else {
			try {
				int pageBlock = 5;
				int commentCount = portfolioService.selectCommentCount(pot_no);
				int pageCount = commentCount/row + (commentCount%row==0? 0:1);
				int startPage = ((page-1)/pageBlock) * pageBlock + 1;
				int endPage = startPage + pageBlock - 1;
				
				if(endPage > pageCount) {
					endPage = pageCount;
				}
				
				Map<String, Integer> map = new HashMap<String, Integer>();
				map.put("no", pot_no);
				map.put("page", (page-1)*row+1);
				map.put("row", row);

				dto.setList(portfolioService.selectPortfolioComments(map));
				
				if(dto.getList() != null) {
					dto.setPage(page);
					dto.setRow(row);
					dto.setPageBlock(pageBlock);
					dto.setPageCount(pageCount);
					dto.setStartPage(startPage);
					dto.setEndPage(endPage);
					dto.setCount(dto.getList().size());
					dto.setCommentCount(commentCount);
					dto.setStatus("Ok");
				} else {
					dto.setStatus("Fail");
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return dto;
	}
	
	// 포트폴리오 댓글 수정
	@PostMapping("/comment/update")
	public String commmentUpdate(CommentDTO dto, BindingResult result) {
		
		if(dto.getCom_no() == 0 || dto.getCom_content() == null || dto.getCom_content().length() == 0 || dto.getCom_type() == 0) {
			return "Fail";
		} else {
			try {
				if(dto.getCom_type() == 1) {
					if(dto.getCom_pw() == null || dto.getCom_pw().length() == 0) {
						return "Fail";
					}
					String password = portfolioService.selectCommentPassword(dto.getCom_no());
					
					if(password.equals(dto.getCom_pw())) {
						Map<String, String> map = new HashMap<String, String>();
						map.put("no", String.valueOf(dto.getCom_no()));
						map.put("content", dto.getCom_content());
						
						int count = portfolioService.updatePortfolioComment(map);
						if(count == 1) {
							return "Ok";
						}
					} else {
						return "Wrong";
					}
				} else if(dto.getCom_type() == 2) {
					Map<String, String> map = new HashMap<String, String>();
					map.put("no", String.valueOf(dto.getCom_no()));
					map.put("content", dto.getCom_content());
					
					int count = portfolioService.updatePortfolioComment(map);
					if(count == 1) {
						return "Ok";
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return "Fail";
	}
	
	// 포트폴리오 댓글 삭제
	@PostMapping("/comment/delete")
	public String commmentDelete(CommentDTO dto) {

		if(!(dto.getCom_no() == 0 || dto.getCom_type() == 0)) {
			try {
				if(dto.getCom_type() == 1) {
					if(dto.getCom_pw() == null || dto.getCom_pw().length() == 0) {
						return "Fail";
					}
					String password = portfolioService.selectCommentPassword(dto.getCom_no());
					
					if(password.equals(dto.getCom_pw())) {
						int count = portfolioService.deletePortfolioComment(dto.getCom_no());
						if(count == 1) {
							portfolioService.deletePortfolioReComments(dto.getCom_no());
							return "Ok";
						}
					} else {
						return "Wrong";
					}
				} else if(dto.getCom_type() == 2) {
					int count = portfolioService.deletePortfolioComment(dto.getCom_no());
					if(count == 1) {
						portfolioService.deletePortfolioReComments(dto.getCom_no());
						return "Ok";
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return "Fail";
	}
	
	// 포트폴리오 답글 작성
	@PostMapping("/recomment/write")
	public String recommmentWrite(ReCommentDTO dto, BindingResult result) {
		
		ReCommentValidator validation = new ReCommentValidator();
		
		if(validation.supports(dto.getClass())) {
			
			validation.validate(dto, result);
			
			if(result.hasErrors()) {
				return "Fail";
			} else {
				try {
					int count = portfolioService.insertPortfolioReComment(dto);
					if(count == 1) {
						return "Ok";
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		
		return "Fail";
	}
	
	// 포트폴리오 답글 불러오기
	@PostMapping("/recomment/list")
	public RestReCommentDTO recommentList(@RequestParam(value = "pot_no", defaultValue = "0") int pot_no) {
		
		RestReCommentDTO dto = new RestReCommentDTO();
		
		if(pot_no == 0) {
			dto.setStatus("Fail");
			return dto;
		} else {
			try {
				dto.setList(portfolioService.selectPortfolioReComments(pot_no));
				
				if(dto.getList() != null) {
					dto.setCount(dto.getList().size());
					dto.setStatus("Ok");
				} else {
					dto.setStatus("Fail");
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return dto;
	}
	
	// 포트폴리오 답글 삭제
	@PostMapping("/recomment/delete")
	public String recommmentDelete(ReCommentDTO dto) {

		if(!(dto.getRcom_no() == 0 || dto.getRcom_type() == 0)) {
			try {
				if(dto.getRcom_type() == 1) {
					if(dto.getRcom_pw() == null || dto.getRcom_pw().length() == 0) {
						return "Fail";
					}
					String password = portfolioService.selectReCommentPassword(dto.getRcom_no());
					
					if(password.equals(dto.getRcom_pw())) {
						int count = portfolioService.deletePortfolioReComment(dto.getRcom_no());
						if(count == 1) {
							return "Ok";
						}
					} else {
						return "Wrong";
					}
				} else if(dto.getRcom_type() == 2) {
					int count = portfolioService.deletePortfolioReComment(dto.getRcom_no());
					if(count == 1) {
						return "Ok";	
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return "Fail";
	}
	
	// 포트폴리오 추천
	@PostMapping("/recommend")
	public String recommend(@RequestParam(value = "mem_no", defaultValue = "0") int mem_no,
			@RequestParam(value = "pot_no", defaultValue = "0") int pot_no,
			HttpServletRequest request) {
		
		if(pot_no != 0) {
			Map<String, String> map = new HashMap<String, String>();
			map.put("mem_no", String.valueOf(mem_no));
			map.put("ip", request.getRemoteAddr());
			map.put("pot_no", String.valueOf(pot_no));
			
			try {
				int count = portfolioService.isAlreadyRecommend(map);
					
				if(count == 0) {
					int count2 = portfolioService.insertRecommendHistory(map);
					count2 += portfolioService.updatePortfolioRecommend(pot_no);
					if(count2 == 2) {
						return "Ok";
					}
				} else {
					return "Already";
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		
		}
		
		return "Fail";
	}
	
	// 선택 회원 포트폴리오 목록
	@PostMapping("/list")
	public RestPortfolio list(@RequestParam(value = "mem_no", defaultValue = "0") int mem_no) {
		
		RestPortfolio dto = new RestPortfolio();
		
		if(mem_no != 0) {			
			try {
				dto.setList(portfolioService.selectMemberPortfolio(mem_no));
				
				if(dto.getList() != null) {
					dto.setCount(dto.getList().size());
					dto.setStatus("Ok");
				}

				MemberDTO dto2 = memberService.selectMemberInfo(mem_no);
				
				if(dto2 == null) {
					dto.setStatus("Fail");
				} else {
					dto.setMem_no(dto2.getMem_no());
					dto.setMem_nickname(dto2.getMem_nickname());
					dto.setMem_id(dto2.getMem_id());
					dto.setMem_profile(dto2.getMem_profile());
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return dto;
	}
	
	// 포트폴리오 수정
	@PostMapping("/updateOk")
	public String updateOk(PortfolioDTO dto, BindingResult result) {
		
		PortfolioValidator validation = new PortfolioValidator();
		if(validation.supports(dto.getClass())) {
			
			validation.validate(dto, result);

			if(result.hasErrors()) {
				return "Fail";
			} else {
				try {
					int count = portfolioService.updatePortfolio(dto);
					
					if(count == 1) {
						// 기존의 포트폴리오 File 테이블의 데이터 삭제
						portfolioService.deletePortfolioFiles(dto.getPot_no());
						FileDTO files = new FileDTO();
						files.setPot_no(dto.getPot_no());
						for(int i=0; i<dto.getFiles().length; i++) {
							files.setFile_name(dto.getFiles()[i]);
							// File 새로 추가
							portfolioService.insertPortfolioFiles(files);
						}
						return "Ok";
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}

		return "Fail";
	}
	
	// 포트폴리오 삭제
	@PostMapping("/deleteOk")
	public String deleteOk(@RequestParam(value = "pot_no", defaultValue = "0") int pot_no) {
		
		if(pot_no != 0) {
			try {
				int count = portfolioService.deletePortfolio(pot_no);
				
				if(count == 1) {
					return "Ok";
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return "Fail";
	}
	
}