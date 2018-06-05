
[Forma]
Clave=MFALayoutPeriodo
Icono=0
Modulos=(Todos)
Nombre=MFA - Captura Manual por Periodo

ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialAlturaCliente=354
PosicionInicialAncho=362
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=502
PosicionInicialArriba=168
[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MFALayoutPeriodo
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

[Lista.MFALayoutPeriodo.Ejercicio]
Carpeta=Lista
Clave=MFALayoutPeriodo.Ejercicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.MFALayoutPeriodo.Periodo]
Carpeta=Lista
Clave=MFALayoutPeriodo.Periodo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.Columnas]
Ejercicio=124
Periodo=139


PeriodoID=220
RID=64
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

[Acciones.Documentos]
Nombre=Documentos
Boton=47
NombreEnBoton=S
NombreDesplegar=&Documentos
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=MFALayoutDocumento
Activo=S
Visible=S

GuardarAntes=S
EspacioPrevio=S
Antes=S





































































































DespuesGuardar=S

AntesExpresiones=Asigna(Info.Titulo, SQL(<T>SELECT PeriodoID FROM MFALayoutPeriodo WHERE RID = :nRID<T>, MFALayoutPeriodo:MFALayoutPeriodo.RID))<BR>Asigna(Info.Ejercicio, MFALayoutPeriodo:MFALayoutPeriodo.Ejercicio)<BR>Asigna(Info.Periodo, MFALayoutPeriodo:MFALayoutPeriodo.Periodo)
[Acciones.Aplicacion]
Nombre=Aplicacion
Boton=35
NombreEnBoton=S
NombreDesplegar=&Aplicaciones
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=MFALayoutAplicacion
Activo=S
Visible=S

EspacioPrevio=S


















Antes=S
















































































GuardarAntes=S
DespuesGuardar=S























































































































AntesExpresiones=Asigna(Info.Titulo, SQL(<T>SELECT PeriodoID FROM MFALayoutPeriodo WHERE RID = :nRID<T>, MFALayoutPeriodo:MFALayoutPeriodo.RID))<BR>Asigna(Info.Ejercicio, MFALayoutPeriodo:MFALayoutPeriodo.Ejercicio)<BR>Asigna(Info.Periodo, MFALayoutPeriodo:MFALayoutPeriodo.Periodo)



[Lista.ListaEnCaptura]
(Inicio)=MFALayoutPeriodo.Ejercicio
MFALayoutPeriodo.Ejercicio=MFALayoutPeriodo.Periodo
MFALayoutPeriodo.Periodo=(Fin)















[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Documentos
Documentos=Aplicacion
Aplicacion=(Fin)
