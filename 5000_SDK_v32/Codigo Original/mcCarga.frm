[Forma]
Clave=mcCarga
Nombre=Carga en Lote
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=535
PosicionInicialArriba=402
PosicionInicialAlturaCliente=360
PosicionInicialAncho=850
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=mcCarga
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

[Lista.mcCarga.FechaEmision]
Carpeta=Lista
Clave=mcCarga.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.mcCarga.Observaciones]
Carpeta=Lista
Clave=mcCarga.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.mcCarga.Tipo]
Carpeta=Lista
Clave=mcCarga.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Lista.Columnas]
FechaEmision=94
Observaciones=519
Tipo=103
EstatusNombre=94

[Lista.EstatusNombre]
Carpeta=Lista
Clave=EstatusNombre
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Gris

[Acciones.Cuentas]
Nombre=Cuentas
Boton=47
NombreEnBoton=S
NombreDesplegar=&Cuentas Mayor
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=mcCargaMayor
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(mcCarga:mcCarga.FechaEmision)
Antes=S
AntesExpresiones=Asigna(Info.ID, mcCarga:mcCarga.RID)<BR>Asigna(Info.Fecha, mcCarga:mcCarga.FechaEmision)<BR>Asigna(Info.Tipo, mcCarga:mcCarga.Tipo)
DespuesGuardar=S
Visible=S

[Acciones.Afectar]
Nombre=Afectar
Boton=7
NombreEnBoton=S
NombreDesplegar=&Afectar
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
ConfirmarAntes=S
DialogoMensaje=EstaSeguro
TipoAccion=Expresion
Visible=S
Expresion=ProcesarSQL(<T>spMCProcesarCarga :nID<T>, mcCarga:mcCarga.RID)<BR>Forma.ActualizarVista(<T>Lista<T>)
ActivoCondicion=mcCarga:mcCarga.Estatus=EstatusSinAfectar

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cuentas
Cuentas=Afectar
Afectar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=mcCarga.FechaEmision
mcCarga.FechaEmision=mcCarga.Tipo
mcCarga.Tipo=mcCarga.Observaciones
mcCarga.Observaciones=EstatusNombre
EstatusNombre=(Fin)
