
[Forma]
Clave=WebArtVariacion
Icono=0
Modulos=(Todos)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
Nombre=Variaciones Artículos eCommerce

ListaCarpetas=WebArtVariacion
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
CarpetaPrincipal=WebArtVariacion
ListaAcciones=(Lista)
PosicionInicialIzquierda=489
PosicionInicialArriba=302
PosicionInicialAlturaCliente=325
PosicionInicialAncho=650
VentanaSinIconosMarco=S
[WebArtVariacion]
Estilo=Hoja
Clave=WebArtVariacion
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=WebArtVariacion
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=WebArtVariacion.Nombre
CarpetaVisible=S

PermiteEditar=S
OtroOrden=S
ListaOrden=WebArtVariacion.Orden<TAB>(Acendente)
HojaPermiteInsertar=S
[WebArtVariacion.WebArtVariacion.Nombre]
Carpeta=WebArtVariacion
Clave=WebArtVariacion.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco


[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

ConCondicion=S
EjecucionConError=S
EspacioPrevio=S
EjecucionCondicion=Asigna(Info.Clase1, ListaBuscarDuplicados(CampoEnLista(WebArtVariacion:WebArtVariacion.Nombre)))<BR>Vacio(Info.Clase1)
EjecucionMensaje=<T>Nombre: <T>+Info.Clase1+<T> Duplicado<T>
[WebArtVariacion.Columnas]
Nombre=566
NumeroOpciones=88
ProveedorID=68

[Acciones.WebArtOpcion]
Nombre=WebArtOpcion
Boton=75
NombreEnBoton=S
NombreDesplegar=Opciones
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Antes=S
DespuesGuardar=S
Visible=S

GuardarAntes=S
ConCondicion=S
EjecucionConError=S
Expresion=Asigna(Temp.Num,SQL(<T>SELECT ID FROM WebArtVariacion WHERE GUID = :tGUID<T>,WebArtVariacion:WebArtVariacion.GUID))<BR>Asigna(Info.Nombre,WebArtVariacion:WebArtVariacion.Nombre)<BR>FormaModal(<T>WebArtOpcion<T>)<BR>ActualizarForma
EjecucionCondicion=Asigna(Info.Clase1, ListaBuscarDuplicados(CampoEnLista(SerieLoteMov:SerieLoteMov.SerieLote)))<BR>Vacio(Info.Clase1)
EjecucionMensaje=<T>Nombre: <T>+Info.Clase1+<T> Duplicado<T>
AntesExpresiones=Asigna(Info.Nombre,WebArtVariacion:WebArtVariacion.Nombre)<BR>Asigna(Info.ID,WebArtVariacion:WebArtVariacion.ID)<BR>Asigna(Info.TieneMovimientos, WebArtVariacion:WebArtVariacion.TieneWebArt)
[Lista.Columnas]
0=49
1=434

[Acciones.Orden]
Nombre=Orden
Boton=50
NombreEnBoton=S
NombreDesplegar=Cambiar &Orden
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Antes=S
DespuesGuardar=S
Visible=S

ConCondicion=S
EjecucionCondicion=Asigna(Info.Clase1, ListaBuscarDuplicados(CampoEnLista(WebArtVariacion:WebArtVariacion.Nombre)))<BR>Vacio(Info.Clase1)
EjecucionMensaje=<T>Nombre: <T>+Info.Clase1+<T> Duplicado<T>
EjecucionConError=S
AntesExpresiones=FormaModal(<T>WebArtVariacionOrdenar<T>)
[WebArtOpcion.Columnas]
Nombre=580
OpcionIntelisis=76


Descripcion=64
[Acciones.Registro Eliminar]
Nombre=Registro Eliminar
Boton=5
NombreEnBoton=S
NombreDesplegar=&Eliminar
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Visible=S
ConCondicion=S
EjecucionConError=S
GuardarAntes=S

ActivoCondicion=no WebArtVariacion:WebArtVariacion.TieneWebArt
EjecucionCondicion=Asigna(Info.Estado,SQL(<T>SELECT dbo.fneWebVerificarWebArtVariacion(:nID)<T>,WebArtVariacion:WebArtVariacion.ID))<BR>Vacio(Info.Estado)
EjecucionMensaje=Info.Estado
[Acciones.Expresion]
Nombre=Expresion
Boton=92
NombreEnBoton=S
NombreDesplegar=&Regenerar
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S






























































































Expresion=Asigna(Temp.Num,SQL(<T>SELECT ID FROM WebArtVariacion WHERE GUID = :tGUID<T>,WebArtVariacion:WebArtVariacion.GUID))<BR>SI Precaucion(<T>Este Proceso Puede Durar varios Minutos Y Puede Borrar Datos Importantes<T>+NuevaLinea+<T>Esta Seguro Que Desea Generar Las Combinaciones?<T>,BotonAceptar,BotonCancelar) = BotonAceptar Entonces   ProcesarSQL(<T>spWebArtReGenerarCombinaciones :nIDVar<T>,Temp.Num))
ConCondicion=S
EjecucionCondicion=Asigna(Info.Clase1, ListaBuscarDuplicados(CampoEnLista(SerieLoteMov:SerieLoteMov.SerieLote)))<BR>Vacio(Info.Clase1)
EjecucionMensaje=<T>Nombre: <T>+Info.Clase1+<T> Duplicado<T>
EjecucionConError=S


























[Acciones.CopiarVariacion]
Nombre=CopiarVariacion
Boton=54
NombreEnBoton=S
NombreDesplegar=Copiar Variación
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S


































EspacioPrevio=S


Expresion=Asigna(Info.Titulo, WebArtVariacion:WebArtVariacion.Nombre)        <BR>Asigna(Temp.Texto, Nulo)<BR>Si FormaModal(<T>WebArtVariacionCopiar<T>) Entonces<BR>  EJECUTARSQL(<T>EXEC speCommerceCopiarVariacion :nID, :tNombre<T>, WebArtVariacion:WebArtVariacion.ID, Temp.Texto)<BR>  ActualizarForma<BR>Fin
[Acciones.CopiarVariacion.ListaAccionesMultiples]
(Inicio)=Copiar
Copiar=Refrescar
Refrescar=(Fin)
















































































































































[Acciones.aaa]
Nombre=aaa
Boton=0
NombreDesplegar=aaa
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S
















































































































































































































[Acciones.Cerrar]
Nombre=Cerrar
Boton=21
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S









[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Aceptar
Aceptar=Registro Eliminar
Registro Eliminar=Orden
Orden=WebArtOpcion
WebArtOpcion=Expresion
Expresion=CopiarVariacion
CopiarVariacion=(Fin)
