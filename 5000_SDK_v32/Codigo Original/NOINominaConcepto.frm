
[Forma]
Clave=NOINominaConcepto
Icono=0
CarpetaPrincipal=NOINominaConcepto
Modulos=(Todos)
Nombre=NOI Nomina Concepto

ListaCarpetas=NOINominaConcepto
PosicionInicialIzquierda=73
PosicionInicialArriba=96
PosicionInicialAlturaCliente=640
PosicionInicialAncho=1084
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
[NOINominaConcepto]
Estilo=Hoja
Clave=NOINominaConcepto
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=NOINominaConcepto
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S

Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=NOINominaConcepto.Estacion ={EstacionTrabajo} AND NOINominaConcepto.Nomina = <T>{Info.Aplica}<T>
[NOINominaConcepto.NOINominaConcepto.NominaConcepto]
Carpeta=NOINominaConcepto
Clave=NOINominaConcepto.NominaConcepto
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[NOINominaConcepto.NOINominaConcepto.Concepto]
Carpeta=NOINominaConcepto
Clave=NOINominaConcepto.Concepto
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[NOINominaConcepto.NOINominaConcepto.Movimiento]
Carpeta=NOINominaConcepto
Clave=NOINominaConcepto.Movimiento
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[NOINominaConcepto.NOINominaConcepto.GravaISR]
Carpeta=NOINominaConcepto
Clave=NOINominaConcepto.GravaISR
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[NOINominaConcepto.NOINominaConcepto.GravaIMSS]
Carpeta=NOINominaConcepto
Clave=NOINominaConcepto.GravaIMSS
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[NOINominaConcepto.NOINominaConcepto.GravaImpuestoEstatal]
Carpeta=NOINominaConcepto
Clave=NOINominaConcepto.GravaImpuestoEstatal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[NOINominaConcepto.NOINominaConcepto.Modulo]
Carpeta=NOINominaConcepto
Clave=NOINominaConcepto.Modulo
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[NOINominaConcepto.NOINominaConcepto.Estatus]
Carpeta=NOINominaConcepto
Clave=NOINominaConcepto.Estatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[NOINominaConcepto.NOINominaConcepto.Pais]
Carpeta=NOINominaConcepto
Clave=NOINominaConcepto.Pais
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[NOINominaConcepto.NOINominaConcepto.CuentaGrupo]
Carpeta=NOINominaConcepto
Clave=NOINominaConcepto.CuentaGrupo
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco



[NOINominaConcepto.Columnas]
NominaConcepto=85
Concepto=304
Movimiento=124
GravaISR=76
GravaIMSS=79
GravaImpuestoEstatal=115
Modulo=45
Estatus=52
Pais=68
CuentaGrupo=77
Ok=64
OkRef=235

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S


GuardarAntes=S

[Acciones.Aceptar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

[Acciones.Aceptar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S



[Acciones.Aceptar.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Aceptar
Aceptar=(Fin)












[Acciones.Importar]
Nombre=Importar
Boton=7
NombreEnBoton=S
NombreDesplegar=&Importar
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S


ConfirmarAntes=S
DialogoMensaje=NOIEstaSeguroCat
Expresion=ProcesarSQL(<T>spNOIGenerarConceptoNomina :tEmpresa,:tNomina,:nEstacion<T>,Empresa,Info.Aplica,EstacionTrabajo)<BR>ActualizarForma
[Acciones.Cancelar]
Nombre=Cancelar
Boton=21
NombreEnBoton=S
NombreDesplegar=&Cancelar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S


[Acciones.Sugerir]
Nombre=Sugerir
Boton=92
NombreEnBoton=S
NombreDesplegar=Sugerir
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S












Expresion=Si<BR>  vacio(Info.Aplica)<BR>Entonces<BR>  Informacion(<T>Es Necesario Asignar Un periodo de Nomina<T>)<BR>Sino<BR>  EjecutarSQL(<T>spNOIImportarConceptoNomina :tEmpresa,:tNomina,:nEstacion<T>,Empresa,Info.Aplica,EstacionTrabajo)<BR>ActualizarForma<BR>Fin


[NOINominaConcepto.ListaEnCaptura]
(Inicio)=NOINominaConcepto.NominaConcepto
NOINominaConcepto.NominaConcepto=NOINominaConcepto.Concepto
NOINominaConcepto.Concepto=NOINominaConcepto.Movimiento
NOINominaConcepto.Movimiento=NOINominaConcepto.GravaISR
NOINominaConcepto.GravaISR=NOINominaConcepto.GravaIMSS
NOINominaConcepto.GravaIMSS=NOINominaConcepto.GravaImpuestoEstatal
NOINominaConcepto.GravaImpuestoEstatal=NOINominaConcepto.Modulo
NOINominaConcepto.Modulo=NOINominaConcepto.Estatus
NOINominaConcepto.Estatus=NOINominaConcepto.Pais
NOINominaConcepto.Pais=NOINominaConcepto.CuentaGrupo
NOINominaConcepto.CuentaGrupo=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=Sugerir
Sugerir=Importar
Importar=(Fin)
