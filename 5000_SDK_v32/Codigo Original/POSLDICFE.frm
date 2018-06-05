
[Forma]
Clave=POSLDICFE
Icono=0
Modulos=(Todos)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=Aceptar
ListaCarpetas=(Variables)
CarpetaPrincipal=(Variables)
PosicionInicialIzquierda=600
PosicionInicialArriba=274
PosicionInicialAlturaCliente=273
PosicionInicialAncho=389
Nombre=Info.Servicio
[Acciones.Aceptar.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Aceptar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Asigna(Temp.Reg2, SQL(<T>EXEC spPOSLDI :tServicio, :tID, :tMonedero,:tEmpresa, :tUsuario,:nSucursal,:nTarjReemp, :Importe, :nEnSilencio, :tNoTel, :nOk, :tOkRef,:tCuenta, :tReferencia<T>, Info.Servicio, Info.IDTexto, Nulo,Empresa, Usuario, sucursal, Nulo, Info.Importe, 0, Nulo, Nulo, Nulo,Info.LDIContrato, Info.LDIReferencia))<BR><BR>Si Temp.Reg2[1] <> Nulo Entonces Error(Temp.Reg2[2]) Fin<BR>Si Temp.Reg2[1] = Nulo Entonces Informacion(Temp.Reg2[3]) Fin<BR>Si Temp.Reg2[1] = Nulo Entonces Asigna(Info.Servicio, Nulo) Fin<BR>Si Temp.Reg2[1] = Nulo Entonces Forma.Accion(<T>Cerrar<T>) Fin<BR><BR>Asigna(Info.LDITelefono, Nulo)<BR>Asigna( Info.LDIReferencia, Nulo)
[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
Multiple=S
EnBarraHerramientas=S
ListaAccionesMultiples=(Lista)

Activo=S
Visible=S

[(Variables)]
Estilo=Ficha
Clave=(Variables)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=(Variables)
Fuente={Tahoma, 20, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S
PermiteEditar=S
ConFuenteEspecial=S
FichaEspacioEntreLineas=0
FichaEspacioNombres=0
FichaColorFondo=Negro




[(Variables).Info.LDIReferencia]
Carpeta=(Variables)
Clave=Info.LDIReferencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[(Variables).ListaEnCaptura]
(Inicio)=Info.LDIContrato
Info.LDIContrato=Info.LDIReferencia
Info.LDIReferencia=(Fin)

[(Variables).Info.LDIContrato]
Carpeta=(Variables)
Clave=Info.LDIContrato
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Acciones.Aceptar.ListaAccionesMultiples]
(Inicio)=Variables Asignar
Variables Asignar=Expresion
Expresion=(Fin)
