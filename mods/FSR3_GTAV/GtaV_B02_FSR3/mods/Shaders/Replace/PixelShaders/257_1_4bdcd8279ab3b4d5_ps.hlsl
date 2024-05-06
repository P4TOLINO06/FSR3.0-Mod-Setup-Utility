// ---- FNV Hash 4bdcd8279ab3b4d5

// ---- Created with 3Dmigoto v1.3.16 on Mon Nov 20 02:47:58 2023
Texture2D<float4> t14 : register(t14);

Texture2D<float4> t9 : register(t9);

Texture2D<float4> t8 : register(t8);

Texture2D<float4> t7 : register(t7);

Texture2D<float4> t6 : register(t6);

Texture2D<float4> t5 : register(t5);

Texture2D<float4> t4 : register(t4);

Texture2D<float4> t3 : register(t3);

Texture2D<float4> t0 : register(t0);

SamplerState s14_s : register(s14);

SamplerState s9_s : register(s9);

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
  float4 v5 : TEXCOORD4,
  float3 v6 : TEXCOORD5,
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
  float4 r0,r1,r2,r3,r4,r5,r6,r7,r8,r9;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = cb11[0].xx * v1.xy;
  r0.zw = cb11[6].ww * v1.xy;
  r1.xyzw = t5.Sample(s5_s, v1.zw).xyzw;
  r2.xyzw = t0.Sample(s0_s, r0.xy).xyzw;
  r0.x = dot(v2.xyz, v2.xyz);
  r0.x = rsqrt(r0.x);
  r3.xyz = v2.yxz * r0.xxx;
  r0.xy = t7.Sample(s7_s, v1.zw).xy;
  r0.xy = r0.xy * float2(2,2) + float2(-1,-1);
  r3.w = dot(r0.xy, r0.xy);
  r3.w = 1 + -r3.w;
  r3.w = sqrt(abs(r3.w));
  r4.x = max(cb11[9].x, 0.00100000005);
  r0.xy = r4.xx * r0.xy;
  r4.xyz = v6.yxz * r0.yyy;
  r4.xyz = r0.xxx * v5.yxz + r4.xyz;
  r4.xyz = r3.www * v2.yxz + r4.xyz;
  r0.x = dot(r4.xyz, r4.xyz);
  r0.x = rsqrt(r0.x);
  r5.xyzw = t8.Sample(s8_s, r0.zw).xyzw;
  r5.xy = r5.xy * r5.xy;
  r0.y = dot(r5.xyz, cb11[6].xyz);
  r0.z = cb11[5].y * r0.y;
  r0.w = cb11[5].x * r5.w;
  r3.w = dot(v4.xyz, v4.xyz);
  r3.w = rsqrt(r3.w);
  r5.xyz = v4.xyz * r3.www;
  r4.w = cmp(0 < cb11[1].x);
  if (r4.w != 0) {
    r5.x = saturate(dot(r3.yxz, r5.xyz));
    r5.y = 0;
    r5.xyz = t9.Sample(s9_s, r5.xy).xyz;
  } else {
    r5.xyz = cb11[0].yzw;
  }
  r4.w = dot(r5.xyz, float3(0.212599993,0.715200007,0.0722000003));
  r6.xyzw = float4(0.075000003,0.075000003,0.075000003,0.075000003) + r5.xyyz;
  r6.xyzw = cmp(r5.yxzy < r6.xyzw);
  r6.x = r6.y ? r6.x : 0;
  r6.x = r6.z ? r6.x : 0;
  r6.x = r6.w ? r6.x : 0;
  r6.y = cmp(0.779999971 < r4.w);
  r6.x = r6.x ? r6.y : 0;
  r6.yzw = float3(0.796000004,0.796000004,0.796000004) * r5.xyz;
  r5.xyz = r6.xxx ? r6.yzw : r5.xyz;
  r6.xyz = r5.xyz * r2.xyz;
  r7.xy = cb11[10].zz * v1.xy;
  r8.xyzw = t3.Sample(s3_s, r7.xy).xyzw;
  r7.xyz = t4.Sample(s4_s, r7.xy).xyz;
  r6.w = saturate(v4.w + v4.w);
  r7.w = -0.5 + v4.w;
  r7.w = saturate(r7.w + r7.w);
  r6.w = r6.w * r8.w;
  r5.xyz = -r2.xyz * r5.xyz + r8.xyz;
  r5.xyz = r6.www * r5.xyz + r6.xyz;
  r6.xyz = r7.xyz + -r5.xyz;
  r5.xyz = r7.www * r6.xyz + r5.xyz;
  r1.w = cb11[2].w * r1.w;
  r1.xyz = cb11[2].xyz * r1.xyz + -r5.xyz;
  r2.xyz = r1.www * r1.xyz + r5.xyz;
  r1.xyz = r4.xyz * r0.xxx + -r3.xyz;
  r1.xyz = r1.www * r1.xyz + r3.xyz;
  r2.xyzw = v3.xxxw * r2.xyzw;
  r3.xy = cb2[12].zy * v3.xx;
  r0.x = saturate(cb3[49].w + cb2[13].z);
  r4.y = r3.y * r0.x;
  r0.x = v3.x * r0.z;
  r0.x = v2.w * r0.x;
  r3.yz = -cb11[3].zz + float2(1,2);
  r0.z = v3.z * r3.y;
  r5.xy = v1.xy * r3.zz;
  r6.xyz = t6.Sample(s6_s, r5.xy).xyz;
  r1.w = t6.Load(float4(0,0,0,0), int3(0, 0, 0)).w;
  r3.z = cmp(0.49000001 < r1.w);
  r1.w = cmp(r1.w < 0.50999999);
  r1.w = r1.w ? r3.z : 0;
  r3.z = saturate(cb11[3].y * 2.5 + -1.5);
  r3.z = r6.x * r3.z;
  r7.y = 1.29999995 * r3.z;
  r7.z = r6.y;
  r7.yz = r1.ww ? r7.yz : r6.yz;
  r1.w = t6.Sample(s6_s, r5.xy, int2(0, 0)).x;
  r3.z = t6.Sample(s6_s, r5.xy, int2(0, 0)).x;
  r4.z = t6.Sample(s6_s, r5.xy, int2(0, 0)).x;
  r5.x = t6.Sample(s6_s, r5.xy, int2(0, 0)).x;
  r1.w = 0.333333313 * r1.w;
  r3.z = 0.333333313 * r3.z;
  r4.z = 0.333333313 * r4.z;
  r5.x = 0.333333313 * r5.x;
  r4.w = -0.0170000009 + r4.w;
  r5.y = dot(cb11[4].xyz, float3(0.212599993,0.715200007,0.0722000003));
  r4.w = cmp(r4.w < r5.y);
  r1.w = r4.w ? r1.w : -r1.w;
  r3.z = r4.w ? r3.z : -r3.z;
  r4.z = r4.w ? r4.z : -r4.z;
  r4.w = r4.w ? r5.x : -r5.x;
  r4.z = r4.w + -r4.z;
  r5.x = r4.z + r4.z;
  r1.w = r3.z + -r1.w;
  r5.y = r1.w + r1.w;
  r1.w = -r5.x * r5.x + 1;
  r1.w = -r5.y * r5.y + r1.w;
  r5.z = sqrt(r1.w);
  r5.xyz = max(float3(-1,-1,-1), r5.xyz);
  r5.xyz = min(float3(1,1,1), r5.xyz);
  r6.yzw = -cb3[0].xyz + float3(0,0,-1);
  r6.yzw = cb11[8].www * r6.yzw + cb3[0].xyz;
  r8.xyz = v4.xyz * r3.www + -r6.yzw;
  r1.w = dot(r8.xyz, r8.xyz);
  r1.w = rsqrt(r1.w);
  r9.xyz = r8.xyz * r1.www;
  r8.xyz = -r8.xyz * r1.www + float3(1,1,1);
  r8.xyz = sqrt(r8.xyz);
  r1.w = dot(r5.xyz, r8.xyz);
  r3.z = r6.x * r1.w;
  r3.w = cb11[3].z * cb5[3].z;
  r1.w = -r6.x * r1.w + r7.z;
  r7.x = r3.w * r1.w + r3.z;
  r3.zw = cb11[3].xx * r7.xy;
  r1.w = v3.z * r3.y + -1;
  r1.w = r3.y * r1.w + 1;
  r3.y = r3.z * r1.w;
  r5.xyz = cb11[4].xyz * cb11[3].yyy;
  r5.xyz = r5.xyz * float3(1.07558298,0.994183481,0.930233717) + -r2.xyz;
  r2.xyz = r3.yyy * r5.xyz + r2.xyz;
  r0.z = cb11[3].x * r0.z;
  r5.xyz = r7.zzz + -r2.xyz;
  r2.xyz = r0.zzz * r5.xyz + r2.xyz;
  r0.z = -r3.w * r1.w + 1;
  r5.x = r0.x * r0.z;
  r1.w = cmp(0 < cb11[7].y);
  if (r1.w != 0) {
    r1.w = cb11[7].y * cb11[3].w;
    r1.w = v3.x * r1.w;
    r0.y = r1.w * r0.y;
    r1.w = cmp(1.5 < abs(cb11[1].x));
    if (r1.w != 0) {
      r6.x = saturate(dot(r1.yxz, -r6.yzw));
      r6.y = 0;
      r3.yzw = t14.Sample(s14_s, r6.xy).xyz;
    } else {
      r3.yzw = cb11[8].xyz;
    }
    r3.yzw = r3.yzw * r0.yyy;
    r0.y = dot(r1.yxz, r9.xyz);
    r0.y = saturate(9.99999994e-09 + r0.y);
    r1.w = cb11[7].x * r5.w + 9.99999994e-09;
    r0.y = log2(r0.y);
    r0.y = r1.w * r0.y;
    r0.y = exp2(r0.y);
    r2.xyz = r3.yzw * r0.yyy + r2.xyz;
  }
  r2.xyz = min(float3(240,240,240), r2.xyz);
  r6.w = cb2[12].x * r2.w;
  r1.xyw = r1.xyz * float3(0.5,0.5,0.5) + float3(0.5,0.5,0.5);
  r3.yzw = float3(256,256,256) * r1.xyw;
  r3.yzw = floor(r3.zyw);
  r1.xyw = r1.xyw * float3(256,256,256) + -r3.zyw;
  r1.xyw = float3(8,8,4) * r1.xyw;
  r1.xyw = floor(r1.xyw);
  r0.y = dot(r1.xyw, float3(4,32,1));
  o1.w = 0.00392156886 * r0.y;
  o1.xyz = float3(0.00390625,0.00390625,0.00390625) * r3.yzw;
  r5.y = 0.001953125 * r0.w;
  r4.x = cb2[12].z * v3.x + cb3[45].w;
  r0.yw = float2(0.5,0.5) * r4.xy;
  o3.xy = sqrt(r0.yw);
  r0.y = -0.349999994 + r1.z;
  r0.y = saturate(1.53846204 * r0.y);
  r0.y = cb5[3].z * r0.y;
  r0.w = -cb2[13].z + 1;
  r0.y = r0.y * r0.w;
  r0.y = r0.y * r3.x;
  r0.w = r5.x * -0.5 + 1;
  r0.w = r0.y * r0.w;
  r0.w = r0.w * -0.5 + 1;
  r6.xyz = r2.xyz * r0.www;
  r0.x = saturate(r0.x * r0.z + 0.400000006);
  r0.xz = r0.xx * float2(0.5,0.48828131) + -r5.xy;
  r0.xz = max(float2(0,0), r0.xz);
  r0.xy = r0.xz * r0.yy + r5.xy;
  o2.xy = sqrt(r0.xy);
  o0.xyzw = cb12[4].xxxx ? v3.xyzw : r6.xyzw;
  o2.z = cb11[4].w;
  o2.w = 1;
  o3.zw = float2(0,1.00188398);
  return;
}