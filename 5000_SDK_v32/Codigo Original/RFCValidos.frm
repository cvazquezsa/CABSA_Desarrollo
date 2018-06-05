
[Forma]
Clave=RFCValidos
Icono=0
Modulos=(Todos)
Nombre=RFC, CURP e IMSS Validos

ListaCarpetas=RFCValidos
CarpetaPrincipal=RFCValidos
PosicionInicialAlturaCliente=335
PosicionInicialAncho=278
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=543
PosicionInicialArriba=211
AutoGuardar=S
[RFCValidos]
Estilo=Hoja
Clave=RFCValidos
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=RFCValidos
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Plata
CarpetaVisible=S
PermiteEditar=S
ListaEnCaptura=(Lista)


[RFCValidos.RFCValidos.Valor]
Carpeta=RFCValidos
Clave=RFCValidos.Valor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[RFCValidos.RFCValidos.Tipo]
Carpeta=RFCValidos
Clave=RFCValidos.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Plata

[RFCValidos.Columnas]
Valor=184
Tipo=60


[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Cancelar Cambios
Activo=S
Visible=S
ConCondicion=S

Antes=S

GuardarAntes=S
EjecucionConError=S
DespuesGuardar=S
Multiple=S
ListaAccionesMultiples=(Lista)
EjecucionCondicion=Asigna(Temp.Texto, ListaBuscarDuplicados(CampoEnLista(RFCValidos:RFCValidos.Valor)))<BR>Vacio(Temp.Texto)
EjecucionMensaje=Comillas(Temp.Texto)+<T> Duplicado<T>
AntesExpresiones=Si<BR> SQL(<T>spRFCValidos<T>) <> <T>1<T><BR>Entonces<BR>  Error(<T>Registro <T> & SQL(<T>spRFCValidos<T>) & <T> <T> & Comillas(<T>Invalido.<T>), BotonAceptar)<BR>  AbortarOperacion<BR>Fin<BR><BR>//Si (SQL(<T>spRFCValidos<T>) <> <T><T>)<BR>//Entonces<BR>//  Error( RFCValidos:RFCValidos.Tipo & <T>: <T> & SQL(<T>spRFCValidos<T>) & <T> <T> & Comillas(<T>Invalido.<T>), BotonCancelar )<BR>//  AbortarOperacion<BR>//Fin
[Acciones.Aceptar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S




Expresion=Si<BR>  SQL(<T>spRFCValidos :tTipo, :tValor, :tEmp<T>, RFCValidos:RFCValidos.Tipo, RFCValidos:RFCValidos.Valor, Empresa) = 0<BR>Entonces<BR>  Error( RFCValidos:RFCValidos.Tipo & <T>: <T> & RFCValidos:RFCValidos.Valor & <T> Invalido<T>, BotonCancelar )<BR>  //Informacion(RFCValidos:RFCValidos.Tipo & <T> Invalido<T>)<BR>  Forma(<T>RFCValidos<T>, AbortarOperacion)<BR>//Sino<BR>//  Forma(<T>RFCValidos<T>, GuardarCambios)<BR>  <BR>Fin
[Acciones.Aceptar.Cerrar]
Nombre=Cerrar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cancelar/Cancelar Cambios
Activo=S
Visible=S



















[Acciones.Aceptar.Cancelar]
Nombre=Cancelar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S






[Acciones.Cerrar]
Nombre=Cerrar
Boton=5
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Ventana
ClaveAccion=Cancelar/Cancelar Cambios




































































































































































[Acciones.Aceptar.Cancelar Cambios]
Nombre=Cancelar Cambios
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Cancelar Cambios
Activo=S
Visible=S

[Acciones.Aceptar.CerrarV]
Nombre=CerrarV
Boton=0
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S








[RFCValidos.ListaEnCaptura]
(Inicio)=RFCValidos.Valor
RFCValidos.Valor=RFCValidos.Tipo
RFCValidos.Tipo=(Fin)


























































































[Acciones.Aceptar.ListaAccionesMultiples]
(Inicio)=Cancelar Cambios
Cancelar Cambios=CerrarV
CerrarV=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cerrar
Cerrar=(Fin)
