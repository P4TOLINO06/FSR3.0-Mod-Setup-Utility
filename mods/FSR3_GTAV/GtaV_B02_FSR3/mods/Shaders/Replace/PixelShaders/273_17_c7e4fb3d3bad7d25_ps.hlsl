// ---- FNV Hash c7e4fb3d3bad7d25

// ---- Created with 3Dmigoto v1.3.16 on Thu Nov 23 17:29:54 2023
Texture2D<float4> t14 : register(t14);

Texture2D<float4> t8 : register(t8);

Texture2D<float4> t7 : register(t7);

Texture2D<float4> t6 : register(t6);

Texture2D<float4> t5 : register(t5);

Texture2D<float4> t4 : register(t4);

Texture2D<float4> t3 : register(t3);

Texture2D<float4> t0 : register(t0);

SamplerState s14_s : register(s14);

SamplerState s8_s : register(s8);

SamplerState s7_s : register(s7);

SamplerState s6_s : register(s6);

SamplerState s5_s : register(s5);

SamplerState s4_s : register(s4);

SamplerState s3_s : register(s3);

SamplerState s0_s : register(s0);

cbuffer cb11 : register(b11)
{
  float4 cb11[11];
}

cbuffer cb12 : register(b12)
{
  float4 cb12[5];
}

cbuffer cb5 : register(b5)
{
  float4 cb5[4];
}

cbuffer cb3 : register(b3)
{
  float4 cb3[50];
}

cbuffer cb2 : register(b2)
{
  float4 cb2[14];
}


cbuffer rage_matrices : register(b1)
{
  row_major float4x4 gWorld : packoffset(c0);
  row_major float4x4 gWorldView : packoffset(c4);
  row_major float4x4 gWorldViewProj : packoffset(c8);
  row_major float4x4 gViewInverse : packoffset(c12);
  row_major float4x4 gWorldViewProjUnjittered : packoffset(c16);
  row_major float4x4 gWorldViewProjUnjitteredPrev : packoffset(c20);
}



// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_Position0,
  float4 v1 : TEXCOORD0,
  float4 v2 : TEXCOORD1,
  float4 v3 : TEXCOORD2,
  float4 v4 : TEXCOORD3,
  float4 pos : POSITION0,
  out float4 o0 : SV_Target0,
  out float4 o1 : SV_Target1,
  out float4 o2 : SV_Target2,
  out float4 o3 : SV_Target3,
  out float2 motionVectors : SV_Target4)
{

  float4 posCurr = mul(pos.xyzw, gWorldViewProjUnjittered);
  float4 posPrev = mul(pos.xyzw, gWorldViewProjUnjitteredPrev);
  posCurr.xy = posCurr.xy/posCurr.ww;
  posPrev.xy = posPrev.xy/posPrev.ww;
  motionVectors.xy = (posPrev.xy-posCurr.xy) * float2(0.5, -0.5);
  float4 r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = cb11[0].xx * v1.xy;
  r0.zw = cb11[6].ww * v1.xy;
  r1.xyzw = t5.Sample(s5_s, v1.zw).xyzw;
  r2.xyzw = t0.Sample(s0_s, r0.xy).xyzw;
  r0.x = dot(v2.xyz, v2.xyz);
  r0.x = rsqrt(r0.x);
  r3.xyz = v2.xyz * r0.xxx;
  r4.xyzw = t7.Sample(s7_s, r0.zw).xyzw;
  r4.xy = r4.xy * r4.xy;
  r0.y = dot(r4.xyz, cb11[6].xyz);
  r0.z = cb11[5].y * r0.y;
  r0.w = cb11[5].x * r4.w;
  r3.w = dot(v4.xyz, v4.xyz);
  r3.w = rsqrt(r3.w);
  r4.xyz = v4.xyz * r3.www;
  r5.x = cmp(0 < cb11[1].x);
  if (r5.x != 0) {
    r4.x = saturate(dot(r3.xyz, r4.xyz));
    r4.y = 0;
    r4.xyz = t8.Sample(s8_s, r4.xy).xyz;
  } else {
    r4.xyz = cb11[0].yzw;
  }
  r5.x = dot(r4.xyz, float3(0.212599993,0.715200007,0.0722000003));
  r6.xyzw = float4(0.075000003,0.075000003,0.075000003,0.075000003) + r4.xyyz;
  r6.xyzw = cmp(r4.yxzy < r6.xyzw);
  r5.y = r6.y ? r6.x : 0;
  r5.y = r6.z ? r5.y : 0;
  r5.y = r6.w ? r5.y : 0;
  r5.z = cmp(0.779999971 < r5.x);
  r5.y = r5.z ? r5.y : 0;
  r6.xyz = float3(0.796000004,0.796000004,0.796000004) * r4.xyz;
  r4.xyz = r5.yyy ? r6.xyz : r4.xyz;
  r4.xyz = r4.xyz * r2.xyz;
  r1.w = cb11[2].w * r1.w;
  r1.xyz = cb11[2].xyz * r1.xyz + -r4.xyz;
  r2.xyz = r1.www * r1.xyz + r4.xyz;
  r1.xyzw = v3.xxxw * r2.xyzw;
  r4.xy = cb2[12].zy * v3.xx;
  r2.w = saturate(cb3[49].w + cb2[13].z);
  r6.y = r4.y * r2.w;
  r4.yz = cb11[10].zz * v1.xy;
  r7.xyzw = t3.Sample(s3_s, r4.yz).xyzw;
  r5.yzw = t4.Sample(s4_s, r4.yz).xyz;
  r2.w = saturate(v4.w + v4.w);
  r4.y = -0.5 + v4.w;
  r4.y = saturate(r4.y + r4.y);
  r2.w = r2.w * r7.w;
  r2.xyz = -r2.xyz * v3.xxx + r7.xyz;
  r1.xyz = r2.www * r2.xyz + r1.xyz;
  r2.xyz = r5.yzw + -r1.xyz;
  r1.xyz = r4.yyy * r2.xyz + r1.xyz;
  r0.z = v3.x * r0.z;
  r0.z = v2.w * r0.z;
  r2.xy = -cb11[3].zz + float2(1,2);
  r2.z = v3.z * r2.x;
  r2.yw = v1.xy * r2.yy;
  r5.yzw = t6.Sample(s6_s, r2.yw).xyz;
  r4.y = t6.Load(float4(0,0,0,0)).w;
  r4.z = cmp(0.49000001 < r4.y);
  r4.y = cmp(r4.y < 0.50999999);
  r4.y = r4.y ? r4.z : 0;
  r4.z = saturate(cb11[3].y * 2.5 + -1.5);
  r4.z = r5.y * r4.z;
  r7.y = 1.29999995 * r4.z;
  r7.z = r5.z;
  r7.yz = r4.yy ? r7.yz : r5.zw;
  r4.y = t6.Sample(s6_s, r2.yw, int2(0, 0)).x;
  r4.z = t6.Sample(s6_s, r2.yw, int2(0, 0)).x;
  r5.z = t6.Sample(s6_s, r2.yw, int2(0, 0)).x;
  r2.y = t6.Sample(s6_s, r2.yw, int2(0, 0)).x;
  r2.w = 0.333332986 * r4.y;
  r4.y = 0.333332986 * r4.z;
  r4.z = 0.333332986 * r5.z;
  r2.y = 0.333332986 * r2.y;
  r5.x = -0.0170000009 + r5.x;
  r5.z = dot(cb11[4].xyz, float3(0.212599993,0.715200007,0.0722000003));
  r5.x = cmp(r5.x < r5.z);
  r4.yz = r5.xx ? r4.yz : -r4.yz;
  r2.yw = r5.xx ? r2.yw : -r2.yw;
  r2.y = r2.y + -r4.z;
  r8.x = r2.y + r2.y;
  r2.y = r4.y + -r2.w;
  r8.y = r2.y + r2.y;
  r2.y = -r8.x * r8.x + 1;
  r2.y = -r8.y * r8.y + r2.y;
  r8.z = sqrt(r2.y);
  r5.xzw = max(float3(-1,-1,-1), r8.xyz);
  r5.xzw = min(float3(1,1,1), r5.xzw);
  r8.xyz = -cb3[0].xyz + float3(0,0,-1);
  r8.xyz = cb11[8].www * r8.xyz + cb3[0].xyz;
  r9.xyz = v4.xyz * r3.www + -r8.xyz;
  r2.y = dot(r9.xyz, r9.xyz);
  r2.y = rsqrt(r2.y);
  r10.xyz = r9.xyz * r2.yyy;
  r9.xyz = -r9.xyz * r2.yyy + float3(1,1,1);
  r9.xyz = sqrt(r9.xyz);
  r2.y = dot(r5.xzw, r9.xyz);
  r2.w = r5.y * r2.y;
  r3.w = cb11[3].z * cb5[3].z;
  r2.y = -r5.y * r2.y + r7.z;
  r7.x = r3.w * r2.y + r2.w;
  r2.yw = cb11[3].xx * r7.xy;
  r3.w = v3.z * r2.x + -1;
  r2.x = r2.x * r3.w + 1;
  r2.y = r2.y * r2.x;
  r5.xyz = cb11[4].xyz * cb11[3].yyy;
  r5.xyz = r5.xyz * float3(1.07558298,0.994183004,0.930234015) + -r1.xyz;
  r1.xyz = r2.yyy * r5.xyz + r1.xyz;
  r2.y = cb11[3].x * r2.z;
  r5.xyz = r7.zzz + -r1.xyz;
  r1.xyz = r2.yyy * r5.xyz + r1.xyz;
  r2.x = -r2.w * r2.x + 1;
  r5.x = r2.x * r0.z;
  r2.y = cmp(0 < cb11[7].y);
  if (r2.y != 0) {
    r2.y = cb11[7].y * cb11[3].w;
    r2.y = v3.x * r2.y;
    r0.y = r2.y * r0.y;
    r2.y = cmp(1.5 < abs(cb11[1].x));
    if (r2.y != 0) {
      r7.x = saturate(dot(r3.xyz, -r8.xyz));
      r7.y = 0;
      r2.yzw = t14.Sample(s14_s, r7.xy).xyz;
    } else {
      r2.yzw = cb11[8].xyz;
    }
    r2.yzw = r2.yzw * r0.yyy;
    r0.y = dot(r3.xyz, r10.xyz);
    r0.y = saturate(0 + r0.y);
    r3.w = cb11[7].x * r4.w + 0;
    r0.y = log2(r0.y);
    r0.y = r3.w * r0.y;
    r0.y = exp2(r0.y);
    r1.xyz = r2.yzw * r0.yyy + r1.xyz;
  }
  r1.xyz = min(float3(240,240,240), r1.xyz);
  r7.w = cb2[12].x * r1.w;
  r2.yzw = r3.xyz * float3(0.5,0.5,0.5) + float3(0.5,0.5,0.5);
  r3.xyz = float3(256,256,256) * r2.yzw;
  r3.xyz = floor(r3.xyz);
  r2.yzw = r2.yzw * float3(256,256,256) + -r3.xyz;
  r2.yzw = float3(8,8,4) * r2.yzw;
  r2.yzw = floor(r2.yzw);
  r0.y = dot(r2.yzw, float3(32,4,1));
  o1.w = 0.00392200006 * r0.y;
  o1.xyz = float3(0.00390599994,0.00390599994,0.00390599994) * r3.xyz;
  r5.y = 0.00195299997 * r0.w;
  r6.x = cb2[12].z * v3.x + cb3[45].w;
  r0.yw = float2(0.5,0.5) * r6.xy;
  o3.xy = sqrt(r0.yw);
  r0.x = v2.z * r0.x + -0.349999994;
  r0.x = saturate(1.53846204 * r0.x);
  r0.x = cb5[3].z * r0.x;
  r0.y = -cb2[13].z + 1;
  r0.x = r0.x * r0.y;
  r0.x = r0.x * r4.x;
  r0.y = r5.x * -0.5 + 1;
  r0.y = r0.x * r0.y;
  r0.y = r0.y * -0.5 + 1;
  r7.xyz = r1.xyz * r0.yyy;
  r0.y = saturate(r2.x * r0.z + 0.400000006);
  r0.yz = r0.yy * float2(0.5,0.488281012) + -r5.xy;
  r0.yz = max(float2(0,0), r0.yz);
  r0.xy = r0.yz * r0.xx + r5.xy;
  o2.xy = sqrt(r0.xy);
  o0.xyzw = cb12[4].xxxx ? v3.xyzw : r7.xyzw;
  o2.z = cb11[4].w;
  o2.w = 1;
  o3.zw = float2(0,1.00188398);
  return;
}