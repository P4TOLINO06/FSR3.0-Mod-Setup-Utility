// ---- FNV Hash b3ec9ddd9657cdf1

// ---- Created with 3Dmigoto v1.3.16 on Thu Nov 23 17:07:12 2023
Texture2D<float4> t14 : register(t14);

Texture2D<float4> t5 : register(t5);

Texture2D<float4> t4 : register(t4);

Texture2D<float4> t3 : register(t3);

Texture2D<float4> t0 : register(t0);

SamplerState s14_s : register(s14);

SamplerState s5_s : register(s5);

SamplerState s4_s : register(s4);

SamplerState s3_s : register(s3);

SamplerState s0_s : register(s0);

cbuffer cb11 : register(b11)
{
  float4 cb11[7];
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

cbuffer cb1 : register(b1)
{
  float4 cb1[16];
  row_major float4x4 gWorldViewProjUnjittered;
  row_major float4x4 gWorldViewProjUnjitteredPrev;
}


// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_Position0,
  float4 v1 : TEXCOORD0,
  float4 v2 : TEXCOORD1,
  float4 v3 : TEXCOORD2,
  float3 v4 : TEXCOORD3,
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
  float4 r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyzw = t0.Sample(s0_s, v1.xy).xyzw;
  r1.x = dot(v2.xyz, v2.xyz);
  r1.x = rsqrt(r1.x);
  r1.yzw = v2.xyz * r1.xxx;
  r2.xyzw = t4.Sample(s4_s, v1.xy).xyzw;
  r3.x = cmp(5 < cb11[4].x);
  r4.x = 0.00157977897 * v2.w;
  r4.y = cb11[4].y * 633;
  r5.x = v2.w;
  r5.y = cb11[4].y;
  r3.xy = r3.xx ? r4.xy : r5.xy;
  r2.xy = r2.xy * r2.xy;
  r2.x = dot(r2.xyz, cb11[5].xyz);
  r2.yz = r3.yy * r2.xw;
  r3.y = dot(v4.xyz, v4.xyz);
  r3.y = rsqrt(r3.y);
  r4.xyz = v4.xyz * r3.yyy;
  r3.z = cmp(0 < cb11[0].w);
  if (r3.z != 0) {
    r4.x = saturate(dot(r1.yzw, r4.xyz));
    r4.y = 0;
    r4.xyz = t5.Sample(s5_s, r4.xy).xyz;
  } else {
    r4.xyz = cb11[0].xyz;
  }
  r3.z = dot(r4.xyz, float3(0.212599993,0.715200007,0.0722000003));
  r5.xyzw = float4(0.075000003,0.075000003,0.075000003,0.075000003) + r4.xyyz;
  r5.xyzw = cmp(r4.yxzy < r5.xyzw);
  r3.w = r5.y ? r5.x : 0;
  r3.w = r5.z ? r3.w : 0;
  r3.w = r5.w ? r3.w : 0;
  r4.w = cmp(0.779999971 < r3.z);
  r3.w = r4.w ? r3.w : 0;
  r5.xyz = float3(0.796000004,0.796000004,0.796000004) * r4.xyz;
  r4.xyz = r3.www ? r5.xyz : r4.xyz;
  r0.xyz = r4.xyz * r0.xyz;
  r0.xyzw = v3.xxxw * r0.xyzw;
  r4.xy = cb2[12].zy * v3.xx;
  r3.w = saturate(cb3[49].w + cb2[13].z);
  r5.y = r4.y * r3.w;
  r2.y = v3.x * r2.y;
  r2.y = r3.x * r2.y;
  r3.xw = -cb11[2].zz + float2(1,2);
  r4.y = v3.z * r3.x;
  r4.zw = v1.xy * r3.ww;
  r3.w = cmp(160.000000 == cb11[4].x);
  if (r3.w != 0) {
    r3.w = cb2[4].x * 4;
    r3.w = cb2[13].x * 0.00400000019 + r3.w;
    r5.z = 0.100000001 * r3.w;
    r6.xyzw = v2.xyxy * float4(2,2,2,2) + r5.zzzz;
    r7.xy = floor(r6.zw);
    r7.zw = float2(1,1) + r7.xy;
    r6.xyzw = -r7.xyzw + r6.xyzw;
    r7.xyzw = float4(0.105999999,5.57399988,0.105999999,5.57399988) * r7.xyzw;
    r7.xyzw = frac(r7.xyzw);
    r8.xyzw = float4(3.99399996,7.72800016,3.99399996,7.72800016) + r7.xyzw;
    r9.xyzw = r8.xxzz * r7.ywyw;
    r8.xyzw = r7.xxzz * r8.ywyw + r9.xyzw;
    r9.xyzw = r8.xyzw + r7.xxzz;
    r7.xyzw = r8.xyzw + r7.ywyw;
    r7.xyzw = r9.xyzw * r7.xyzw;
    r7.xyzw = frac(r7.xyzw);
    r3.w = 6 + r3.w;
    r7.xyzw = r7.xyzw * r3.wwww;
    sincos(r7.xyzw, r7.xyzw, r8.xyzw);
    r7.xyzw = r7.xyzw * r6.ywyw;
    r7.xyzw = r8.xyzw * r6.xxzz + r7.xyzw;
    r6.zw = -r6.xy * float2(2,2) + float2(3,3);
    r6.xy = r6.xy * r6.xy;
    r6.xy = r6.zw * r6.xy;
    r6.zw = r7.zw + -r7.xy;
    r6.xz = r6.xx * r6.zw + r7.xy;
    r5.w = r6.z + -r6.x;
    r6.x = r6.y * r5.w + r6.x;
    r7.xyzw = v2.xyxy * float4(6,6,3,3) + r5.zzzz;
    r7.xyzw = float4(8,8,4,4) + r7.xyzw;
    r8.xyzw = floor(r7.xyzw);
    r9.xyzw = float4(0,0,1,1) + r8.xyxy;
    r10.xyzw = -r9.xyzw + r7.xyxy;
    r9.xyzw = float4(0.105999999,5.57399988,0.105999999,5.57399988) * r9.xyzw;
    r9.xyzw = frac(r9.xyzw);
    r11.xyzw = float4(3.99399996,7.72800016,3.99399996,7.72800016) + r9.xyzw;
    r12.xyzw = r11.xxzz * r9.ywyw;
    r11.xyzw = r9.xxzz * r11.ywyw + r12.xyzw;
    r12.xyzw = r11.xyzw + r9.xxzz;
    r9.xyzw = r11.xyzw + r9.ywyw;
    r9.xyzw = r12.xyzw * r9.xyzw;
    r9.xyzw = frac(r9.xyzw);
    r9.xyzw = r9.xyzw * r3.wwww;
    sincos(r9.xyzw, r9.xyzw, r11.xyzw);
    r9.xyzw = r9.xyzw * r10.ywyw;
    r9.xyzw = r11.xyzw * r10.xxzz + r9.xyzw;
    r5.zw = -r10.xy * float2(2,2) + float2(3,3);
    r7.xy = r10.xy * r10.xy;
    r5.zw = r7.xy * r5.zw;
    r7.xy = r9.zw + -r9.xy;
    r7.xy = r5.zz * r7.xy + r9.xy;
    r5.z = r7.y + -r7.x;
    r6.y = r5.w * r5.z + r7.x;
    r8.xyzw = float4(0,0,1,1) + r8.zwzw;
    r7.xyzw = -r8.xyzw + r7.zwzw;
    r8.xyzw = float4(0.105999999,5.57399988,0.105999999,5.57399988) * r8.xyzw;
    r8.xyzw = frac(r8.xyzw);
    r9.xyzw = float4(3.99399996,7.72800016,3.99399996,7.72800016) + r8.xyzw;
    r10.xyzw = r9.xxzz * r8.ywyw;
    r9.xyzw = r8.xxzz * r9.ywyw + r10.xyzw;
    r10.xyzw = r9.xyzw + r8.xxzz;
    r8.xyzw = r9.xyzw + r8.ywyw;
    r8.xyzw = r10.xyzw * r8.xyzw;
    r8.xyzw = frac(r8.xyzw);
    r8.xyzw = r8.xyzw * r3.wwww;
    sincos(r8.xyzw, r8.xyzw, r9.xyzw);
    r8.xyzw = r8.xyzw * r7.ywyw;
    r8.xyzw = r9.xyzw * r7.xxzz + r8.xyzw;
    r5.zw = -r7.xy * float2(2,2) + float2(3,3);
    r7.xy = r7.xy * r7.xy;
    r5.zw = r7.xy * r5.zw;
    r7.xy = r8.zw + -r8.xy;
    r7.xy = r5.zz * r7.xy + r8.xy;
    r3.w = r7.y + -r7.x;
    r6.z = r5.w * r3.w + r7.x;
    r3.w = 26 * r6.x;
    r6.xyz = r6.xyz * float3(0.600000024,0.600000024,0.600000024) + float3(0.600000024,0.600000024,0.600000024);
    sincos(r3.w, r7.x, r8.x);
    r7.x = 0.577400029 * r7.x;
    r3.w = 1 + -r8.x;
    r7.z = r8.x;
    r7.y = -r7.x;
    r7.xyz = r3.www * float3(0.333333313,0.333333313,0.333333313) + r7.xyz;
    r8.x = dot(r6.yzx, r7.xyz);
    r8.y = dot(r6.zxy, r7.xyz);
    r8.z = dot(r6.xyz, r7.xyz);
    r6.xyz = float3(-0.5,-0.5,-0.5) + r8.xyz;
    r7.xyz = -cb3[0].xyz + float3(0,0,-1);
    r7.xyz = cb11[6].www * r7.xyz + cb3[0].xyz;
    r7.xyz = v4.xyz * r3.yyy + -r7.xyz;
    r3.w = dot(r7.xyz, r7.xyz);
    r3.w = rsqrt(r3.w);
    r7.xyz = r7.xyz * r3.www;
    r3.w = dot(r1.yzw, r7.xyz);
    r3.w = saturate(9.99999994e-09 + r3.w);
    r3.w = log2(r3.w);
    r3.w = 15 * r3.w;
    r3.w = exp2(r3.w);
    r0.xyz = r6.xyz * r3.www + r0.xyz;
  }
  r6.xyz = t3.Sample(s3_s, r4.zw).xyz;
  r3.w = t3.Load(float4(0,0,0,0), int3(0, 0, 0)).w;
  r5.z = cmp(0.49000001 < r3.w);
  r3.w = cmp(r3.w < 0.50999999);
  r3.w = r3.w ? r5.z : 0;
  r7.x = cb11[2].x * 110;
  r5.z = saturate(cb11[2].y * 2.5 + -1.5);
  r5.w = r6.x * r5.z;
  r7.y = 1.29999995 * r5.w;
  r7.z = r6.y;
  r8.yz = r3.ww ? r7.yz : r6.yz;
  r3.w = t3.Sample(s3_s, r4.zw, int2(0, 0)).x;
  r5.w = t3.Sample(s3_s, r4.zw, int2(0, 0)).x;
  r6.y = t3.Sample(s3_s, r4.zw, int2(0, 0)).x;
  r6.z = t3.Sample(s3_s, r4.zw, int2(0, 0)).x;
  r3.w = 0.333333313 * r3.w;
  r5.w = 0.333333313 * r5.w;
  r6.yz = float2(0.333333313,0.333333313) * r6.yz;
  r3.z = -0.0170000009 + r3.z;
  r6.w = dot(cb11[3].xyz, float3(0.212599993,0.715200007,0.0722000003));
  r3.z = cmp(r3.z < r6.w);
  r3.w = r3.z ? r3.w : -r3.w;
  r5.w = r3.z ? r5.w : -r5.w;
  r6.y = r3.z ? r6.y : -r6.y;
  r3.z = r3.z ? r6.z : -r6.z;
  r3.z = r3.z + -r6.y;
  r9.x = r3.z + r3.z;
  r3.z = r5.w + -r3.w;
  r9.y = r3.z + r3.z;
  r3.z = -r9.x * r9.x + 1;
  r3.z = -r9.y * r9.y + r3.z;
  r9.z = sqrt(r3.z);
  r6.yzw = max(float3(-1,-1,-1), r9.xyz);
  r6.yzw = min(float3(1,1,1), r6.yzw);
  r7.yzw = -cb3[0].xyz + float3(0,0,-1);
  r7.yzw = cb11[6].www * r7.yzw + cb3[0].xyz;
  r9.xyz = v4.xyz * r3.yyy + -r7.yzw;
  r3.z = dot(r9.xyz, r9.xyz);
  r3.z = rsqrt(r3.z);
  r10.xyz = r9.xyz * r3.zzz;
  r9.xyz = -r9.xyz * r3.zzz + float3(1,1,1);
  r9.xyz = sqrt(r9.xyz);
  r3.z = dot(r6.yzw, r9.xyz);
  r3.w = r6.x * r3.z;
  r5.w = cb11[2].z * cb5[3].z;
  r3.z = -r6.x * r3.z + r8.z;
  r8.x = r5.w * r3.z + r3.w;
  r3.zw = cb11[2].xx * r8.xy;
  r5.w = v3.z * r3.x + -1;
  r3.x = r3.x * r5.w + 1;
  r3.z = r3.z * r3.x;
  r6.yzw = cb11[3].xyz * cb11[2].yyy;
  r6.yzw = r6.yzw * float3(1.07558298,0.994183481,0.930233717) + -r0.xyz;
  r8.xy = cb2[13].ww + float2(-1.25,-1.35000002);
  r5.w = r8.x * r8.y;
  r5.w = saturate(-400 * r5.w);
  r8.x = cmp(0 < r5.w);
  r8.y = log2(r6.x);
  r8.y = 20 * r8.y;
  r8.y = exp2(r8.y);
  r7.x = saturate(r7.x);
  r7.x = r8.y * r7.x;
  r5.w = r7.x * r5.w;
  r7.x = r6.x * r5.w;
  r5.w = -r6.x * r5.w + 1;
  r9.xyz = r0.xyz * r5.www + r7.xxx;
  r0.xyz = r8.xxx ? r9.xyz : r0.xyz;
  r0.xyz = r3.zzz * r6.yzw + r0.xyz;
  r3.z = cb11[2].x * r4.y;
  r6.xyz = r8.zzz + -r0.xyz;
  r0.xyz = r3.zzz * r6.xyz + r0.xyz;
  r3.x = -r3.w * r3.x + 1;
  r6.x = r3.x * r2.y;
  r3.z = cb11[2].w * v3.x;
  r2.x = r3.z * r2.x;
  r2.x = 0.75 * r2.x;
  r3.z = cmp(1.5 < abs(cb11[0].w));
  if (r3.z != 0) {
    r7.x = saturate(dot(r1.yzw, -r7.yzw));
    r7.y = 0;
    r7.xyz = t14.Sample(s14_s, r7.xy).xyz;
  } else {
    r7.xyz = cb11[6].xyz;
  }
  r7.xyz = r7.xyz * r2.xxx;
  r2.x = dot(r1.yzw, r10.xyz);
  r2.x = saturate(9.99999994e-09 + r2.x);
  r2.w = r2.w * 15 + 9.99999994e-09;
  r2.x = log2(r2.x);
  r2.x = r2.w * r2.x;
  r2.x = exp2(r2.x);
  r0.xyz = r7.xyz * r2.xxx + r0.xyz;
  r0.xyz = min(float3(240,240,240), r0.xyz);
  r7.w = cb2[12].x * r0.w;
  r1.yzw = r1.yzw * float3(0.5,0.5,0.5) + float3(0.5,0.5,0.5);
  r0.w = cmp(cb11[2].y < 1);
  if (r0.w != 0) {
    r2.xw = cmp(r4.zw < float2(0.409999996,0.660000026));
    r0.w = r2.w ? r2.x : 0;
    r2.xw = r4.zw * float2(2,2) + float2(-1,-1);
    r8.xy = float2(4.0999999,4.0999999) * r2.xw;
    r8.z = -r8.y;
    r9.x = dot(r8.xz, float2(-4.37113883e-08,-1));
    r9.y = dot(r8.xz, float2(1,-4.37113883e-08));
    r9.xyzw = float4(0.699999988,0.699999988,0.699999988,0.699999988) * r9.xyyx;
    r8.xyzw = r0.wwww ? r9.xyzw : r8.xzzx;
    r2.xw = float2(1,1.5) + -r5.zz;
    r0.w = 0.666666687 * r2.w;
    r2.w = r2.w * -1.33333302 + 3;
    r0.w = r0.w * r0.w;
    r0.w = dot(r2.ww, r0.ww);
    r2.x = r2.x + r2.x;
    r2.x = min(1, r2.x);
    r2.w = r2.x * -2 + 3;
    r2.x = r2.x * r2.x;
    r2.x = r2.w * r2.x;
    r8.xyzw = float4(0.00100000005,0,0.00100000005,0) + r8.xyzw;
    r4.yzw = float3(22.2000008,37,18.5) * r8.xyy;
    r2.w = cb2[13].x * 0.00374999992;
    r3.z = r8.y * 1.85000002 + r2.w;
    r3.w = floor(r4.y);
    r3.w = 12345.5596 * r3.w;
    r3.w = sin(r3.w);
    r3.w = 7658.75977 * r3.w;
    r3.w = frac(r3.w);
    r9.y = r3.z + r3.w;
    r9.xz = r8.xw;
    r3.zw = float2(22.2000008,2) * r9.xy;
    r5.zw = floor(r3.zw);
    r4.y = dot(r5.zw, float2(35.2000008,2376.1001));
    r10.xyz = float3(0.103100002,0.113689996,0.137869999) * r4.yyy;
    r10.xyz = frac(r10.xyz);
    r11.xyz = float3(19.1900005,19.1900005,19.1900005) + r10.yzx;
    r4.y = dot(r10.xyz, r11.xyz);
    r10.xyz = r10.xyz + r4.yyy;
    r5.zw = r10.xy + r10.yz;
    r5.zw = r5.zw * r10.zx;
    r5.zw = frac(r5.zw);
    r10.xy = frac(r3.zw);
    r3.z = -1 + r10.y;
    r6.zw = float2(-0.5,-0.5) + r5.zw;
    r3.w = sin(r4.z);
    r3.w = r8.y * 37 + r3.w;
    r3.w = sin(r3.w);
    r4.y = 0.5 + -abs(r6.z);
    r3.w = r4.y * r3.w;
    r3.w = r3.w * r6.w + r6.z;
    r11.x = 0.699999988 * r3.w;
    r3.w = cb2[13].x * 0.00499999989 + r5.w;
    r3.w = frac(r3.w);
    r4.y = 1.17647099 * r3.w;
    r4.y = min(1, r4.y);
    r4.z = r4.y * -2 + 3;
    r4.y = r4.y * r4.y;
    r4.y = r4.z * r4.y;
    r3.w = -1 + r3.w;
    r3.w = -6.66666794 * r3.w;
    r3.w = min(1, r3.w);
    r4.z = r3.w * -2 + 3;
    r3.w = r3.w * r3.w;
    r3.w = r4.z * r3.w;
    r3.w = r4.y * r3.w + -0.5;
    r11.yz = r3.ww * float2(0.899999976,0.899999976) + float2(0.5,-0.5);
    r10.zw = float2(-0.5,-0.5) + r10.xx;
    r4.yz = -r11.xy + r10.zy;
    r5.zw = float2(1,6) * r4.yz;
    r3.w = dot(r5.zw, r5.zw);
    r3.w = sqrt(r3.w);
    r3.w = -0.400000006 + r3.w;
    r3.w = -2.5 * r3.w;
    r3.w = max(0, r3.w);
    r5.z = r3.w * -2 + 3;
    r5.w = 1 / r11.z;
    r3.z = saturate(r5.w * r3.z);
    r5.w = r3.z * -2 + 3;
    r3.z = r3.z * r3.z;
    r3.z = r5.w * r3.z;
    r5.w = sqrt(r3.z);
    r6.z = 0.200000003 * r5.w;
    r4.y = -r5.w * 0.200000003 + abs(r4.y);
    r6.z = 1 / -r6.z;
    r4.y = saturate(r6.z * r4.y);
    r6.z = r4.y * -2 + 3;
    r4.y = r4.y * r4.y;
    r4.y = r6.z * r4.y;
    r4.z = 0.0199999996 + r4.z;
    r4.z = saturate(25 * r4.z);
    r6.z = r4.z * -2 + 3;
    r4.z = r4.z * r4.z;
    r4.z = r6.z * r4.z;
    r3.z = r4.z * r3.z;
    r12.x = r4.y * r3.z;
    r3.z = frac(r4.w);
    r3.z = r10.y + r3.z;
    r11.w = -0.5 + r3.z;
    r4.yw = -r11.xw + r10.wy;
    r3.z = dot(r4.yw, r4.yw);
    r3.z = sqrt(r3.z);
    r3.z = -0.300000012 + r3.z;
    r3.z = -3.33333302 * r3.z;
    r3.z = max(0, r3.z);
    r4.y = r3.z * -2 + 3;
    r3.zw = r3.zw * r3.zw;
    r3.z = r4.y * r3.z;
    r3.z = r3.z * r5.w;
    r3.z = r3.z * r4.z;
    r3.z = r5.z * r3.w + r3.z;
    r4.yzw = float3(30,30,22.2000008) * r8.xyw;
    r10.xyz = floor(r4.yzw);
    r4.yz = frac(r4.yz);
    r4.yz = float2(-0.5,-0.5) + r4.yz;
    r3.w = dot(r10.xy, float2(107.449997,3543.65405));
    r10.xyw = float3(0.137869999,0.113689996,0.103100002) * r3.www;
    r10.xyw = frac(r10.xyw);
    r11.xyz = float3(19.1900005,19.1900005,19.1900005) + r10.yxw;
    r3.w = dot(r10.wyx, r11.xyz);
    r10.xyw = r10.xyw + r3.www;
    r11.xyz = r10.wwy + r10.yxx;
    r10.xyw = r11.xyz * r10.xyw;
    r10.xyw = frac(r10.xyw);
    r5.zw = float2(-0.5,-0.5) + r10.xy;
    r4.yz = -r5.zw * float2(0.699999988,0.699999988) + r4.yz;
    r3.w = dot(r4.yz, r4.yz);
    r3.w = sqrt(r3.w);
    r3.w = -0.300000012 + r3.w;
    r3.w = -3.33333302 * r3.w;
    r3.w = max(0, r3.w);
    r4.y = r3.w * -2 + 3;
    r3.w = r3.w * r3.w;
    r3.w = r4.y * r3.w;
    r4.y = 10 * r10.w;
    r4.y = frac(r4.y);
    r3.w = r4.y * r3.w;
    r4.y = cb2[13].x * 0.00499999989 + r10.w;
    r4.y = frac(r4.y);
    r4.z = 40 * r4.y;
    r4.z = min(1, r4.z);
    r4.w = r4.z * -2 + 3;
    r4.z = r4.z * r4.z;
    r4.z = r4.w * r4.z;
    r4.y = -1 + r4.y;
    r4.y = -1.02564096 * r4.y;
    r4.y = min(1, r4.y);
    r4.w = r4.y * -2 + 3;
    r4.y = r4.y * r4.y;
    r4.y = r4.w * r4.y;
    r4.y = r4.z * r4.y;
    r3.w = r4.y * r3.w;
    r3.z = r3.z * r2.x;
    r3.z = r3.w * r0.w + r3.z;
    r3.z = -0.300000012 + r3.z;
    r3.z = saturate(0.588235319 * r3.z);
    r3.w = r3.z * -2 + 3;
    r3.z = r3.z * r3.z;
    r4.y = r3.w * r3.z;
    r2.w = r8.z * 1.85000002 + r2.w;
    r4.z = 12345.5596 * r10.z;
    r4.z = sin(r4.z);
    r4.z = 7658.75977 * r4.z;
    r4.z = frac(r4.z);
    r9.w = r4.z + r2.w;
    r4.zw = float2(22.2000008,2) * r9.zw;
    r5.zw = floor(r4.zw);
    r2.w = dot(r5.zw, float2(35.2000008,2376.1001));
    r9.xyz = float3(0.103100002,0.113689996,0.137869999) * r2.www;
    r9.xyz = frac(r9.xyz);
    r10.xyz = float3(19.1900005,19.1900005,19.1900005) + r9.yzx;
    r2.w = dot(r9.xyz, r10.xyz);
    r9.xyz = r9.xyz + r2.www;
    r5.zw = r9.xy + r9.yz;
    r5.zw = r5.zw * r9.zx;
    r5.zw = frac(r5.zw);
    r9.xy = frac(r4.zw);
    r2.w = -1 + r9.y;
    r4.zw = float2(-0.5,-0.5) + r5.zw;
    r10.xyzw = float4(37,18.5,30,30) * r8.zzwz;
    r5.z = sin(r10.x);
    r5.z = r8.z * 37 + r5.z;
    r5.z = sin(r5.z);
    r6.z = 0.5 + -abs(r4.z);
    r5.z = r6.z * r5.z;
    r4.z = r5.z * r4.w + r4.z;
    r8.x = 0.699999988 * r4.z;
    r4.z = cb2[13].x * 0.00499999989 + r5.w;
    r4.z = frac(r4.z);
    r4.w = 1.17647099 * r4.z;
    r4.w = min(1, r4.w);
    r5.z = r4.w * -2 + 3;
    r4.w = r4.w * r4.w;
    r4.w = r5.z * r4.w;
    r4.z = -1 + r4.z;
    r4.z = -6.66666794 * r4.z;
    r4.z = min(1, r4.z);
    r5.z = r4.z * -2 + 3;
    r4.z = r4.z * r4.z;
    r4.z = r5.z * r4.z;
    r4.z = r4.w * r4.z + -0.5;
    r8.yz = r4.zz * float2(0.899999976,0.899999976) + float2(0.5,-0.5);
    r9.zw = float2(-0.5,-0.5) + r9.xx;
    r4.zw = r9.zy + -r8.xy;
    r5.zw = float2(1,6) * r4.zw;
    r5.z = dot(r5.zw, r5.zw);
    r5.z = sqrt(r5.z);
    r5.z = -0.400000006 + r5.z;
    r5.z = -2.5 * r5.z;
    r5.z = max(0, r5.z);
    r5.w = r5.z * -2 + 3;
    r5.z = r5.z * r5.z;
    r6.z = 1 / r8.z;
    r2.w = saturate(r6.z * r2.w);
    r6.z = r2.w * -2 + 3;
    r2.w = r2.w * r2.w;
    r2.w = r6.z * r2.w;
    r6.z = sqrt(r2.w);
    r6.w = 0.200000003 * r6.z;
    r4.z = -r6.z * 0.200000003 + abs(r4.z);
    r6.w = 1 / -r6.w;
    r4.z = saturate(r6.w * r4.z);
    r6.w = r4.z * -2 + 3;
    r4.z = r4.z * r4.z;
    r4.z = r6.w * r4.z;
    r4.w = 0.0199999996 + r4.w;
    r4.w = saturate(25 * r4.w);
    r6.w = r4.w * -2 + 3;
    r4.w = r4.w * r4.w;
    r4.w = r6.w * r4.w;
    r2.w = r4.w * r2.w;
    r12.yz = r4.zz * r2.ww;
    r11.xyz = frac(r10.yzw);
    r2.w = r11.x + r9.y;
    r8.w = -0.5 + r2.w;
    r8.xy = r9.wy + -r8.xw;
    r2.w = dot(r8.xy, r8.xy);
    r2.w = sqrt(r2.w);
    r2.w = -0.300000012 + r2.w;
    r2.w = -3.33333302 * r2.w;
    r2.w = max(0, r2.w);
    r4.z = r2.w * -2 + 3;
    r2.w = r2.w * r2.w;
    r2.w = r4.z * r2.w;
    r2.w = r2.w * r6.z;
    r2.w = r2.w * r4.w;
    r2.w = r5.w * r5.z + r2.w;
    r4.zw = floor(r10.zw);
    r5.zw = float2(-0.5,-0.5) + r11.yz;
    r4.z = dot(r4.zw, float2(107.449997,3543.65405));
    r8.xyz = float3(0.137869999,0.113689996,0.103100002) * r4.zzz;
    r8.xyz = frac(r8.xyz);
    r9.xyz = float3(19.1900005,19.1900005,19.1900005) + r8.yxz;
    r4.z = dot(r8.zyx, r9.xyz);
    r8.xyz = r8.xyz + r4.zzz;
    r9.xyz = r8.zzy + r8.yxx;
    r8.xyz = r9.xyz * r8.xyz;
    r8.xyz = frac(r8.xyz);
    r4.zw = float2(-0.5,-0.5) + r8.xy;
    r4.zw = -r4.zw * float2(0.699999988,0.699999988) + r5.zw;
    r4.z = dot(r4.zw, r4.zw);
    r4.z = sqrt(r4.z);
    r4.z = -0.300000012 + r4.z;
    r4.z = -3.33333302 * r4.z;
    r4.z = max(0, r4.z);
    r4.w = r4.z * -2 + 3;
    r4.z = r4.z * r4.z;
    r4.z = r4.w * r4.z;
    r4.w = 10 * r8.z;
    r4.w = frac(r4.w);
    r4.z = r4.z * r4.w;
    r4.w = cb2[13].x * 0.00499999989 + r8.z;
    r4.w = frac(r4.w);
    r5.z = 40 * r4.w;
    r5.z = min(1, r5.z);
    r5.w = r5.z * -2 + 3;
    r5.z = r5.z * r5.z;
    r5.z = r5.w * r5.z;
    r4.w = -1 + r4.w;
    r4.w = -1.02564096 * r4.w;
    r4.w = min(1, r4.w);
    r5.w = r4.w * -2 + 3;
    r4.w = r4.w * r4.w;
    r4.w = r5.w * r4.w;
    r4.w = r5.z * r4.w;
    r4.z = r4.z * r4.w;
    r2.x = r2.w * r2.x;
    r0.w = r4.z * r0.w + r2.x;
    r0.w = -0.300000012 + r0.w;
    r0.w = saturate(0.588235319 * r0.w);
    r2.x = r0.w * -2 + 3;
    r0.w = r0.w * r0.w;
    r2.w = r2.x * r0.w;
    r8.x = r2.x * r0.w + -r4.y;
    r8.yz = r3.ww * r3.zz + -r2.ww;
    r4.yzw = float3(0.0450000018,0.0450000018,0.0450000018) * r12.xyz;
    r4.yzw = min(float3(1,1,1), r4.yzw);
    r0.w = min(1, r12.x);
    r4.yzw = r4.yzw * r0.www + r8.xyz;
    r4.yzw = max(float3(-0.0250000004,-0.0250000004,-0.0250000004), r4.yzw);
    r0.w = 1.20000005 * r3.y;
    r0.w = max(0.150000006, r0.w);
    r0.w = min(0.899999976, r0.w);
    r3.yzw = r4.yzw * r0.www;
    r0.w = cb1[15].z + -790;
    r0.w = saturate(0.00714285718 * r0.w);
    r0.w = 1 + -r0.w;
    r1.yzw = r3.yzw * r0.www + r1.yzw;
  }
  r3.yzw = float3(256,256,256) * r1.zyw;
  r3.yzw = floor(r3.zyw);
  r1.yzw = r1.zyw * float3(256,256,256) + -r3.zyw;
  r1.yzw = float3(8,8,4) * r1.yzw;
  r1.yzw = floor(r1.yzw);
  r0.w = dot(r1.yzw, float3(4,32,1));
  o1.w = 0.00392156886 * r0.w;
  o1.xyz = float3(0.00390625,0.00390625,0.00390625) * r3.yzw;
  r6.y = 0.001953125 * r2.z;
  r5.x = cb2[12].z * v3.x + cb3[45].w;
  r1.yz = float2(0.5,0.5) * r5.xy;
  o3.xy = sqrt(r1.yz);
  r0.w = v2.z * r1.x + -0.349999994;
  r0.w = saturate(1.53846204 * r0.w);
  r0.w = cb5[3].z * r0.w;
  r1.x = -cb2[13].z + 1;
  r0.w = r1.x * r0.w;
  r0.w = r0.w * r4.x;
  r1.x = r6.x * -0.5 + 1;
  r1.x = r1.x * r0.w;
  r1.x = r1.x * -0.5 + 1;
  r7.xyz = r1.xxx * r0.xyz;
  r0.x = saturate(r3.x * r2.y + 0.400000006);
  r0.xy = r0.xx * float2(0.5,0.48828131) + -r6.xy;
  r0.xy = max(float2(0,0), r0.xy);
  r0.xy = r0.xy * r0.ww + r6.xy;
  o2.xy = sqrt(r0.xy);
  o0.xyzw = cb12[4].xxxx ? v3.xyzw : r7.xyzw;
  o2.z = cb11[3].w;
  o2.w = 1;
  o3.zw = float2(0,1.00188398);
  return;
}