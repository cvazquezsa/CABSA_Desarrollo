[Forma]
Clave=OfertaH
Nombre=<T>Asistente Volumen - <T>+Info.Usar
Icono=1
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=245
PosicionInicialArriba=116
PosicionInicialAlturaCliente=508
PosicionInicialAncho=777
Comentarios=SQLEnLista(<T>SELECT Cantidad FROM OfertaHVol WHERE Estacion=:tEstacion<T>, EstacionTrabajo)
VentanaTipoMarco=Normal
VentanaPosicionInicial=por Diseño
VentanaExclusiva=S
ExpresionesAlMostrar=EjecutarSQL(<T>spOfertaHSugerir :nEstacion, :nID<T>, EstacionTrabajo, Info.ID) <BR>Asigna(Info.Cantidad, SQL(<T>SELECT COUNT(*) FROM OfertaHVol WHERE Estacion=:tEstacion<T>, EstacionTrabajo))

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=OfertaH
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Plata
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
ValidarCampos=S
HojaAjustarColumnas=S
HojaMantenerSeleccion=S
ListaCamposAValidar=(Lista)
FiltroGeneral=OfertaH.Estacion={EstacionTrabajo} AND OfertaH.ID={Info.ID}

[Lista.OfertaH.Articulo]
Carpeta=Lista
Clave=OfertaH.Articulo
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Lista.OfertaH.Monto1]
Carpeta=Lista
Clave=OfertaH.Monto1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.OfertaH.Monto2]
Carpeta=Lista
Clave=OfertaH.Monto2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.OfertaH.Monto3]
Carpeta=Lista
Clave=OfertaH.Monto3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.OfertaH.Monto4]
Carpeta=Lista
Clave=OfertaH.Monto4
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.OfertaH.Monto5]
Carpeta=Lista
Clave=OfertaH.Monto5
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.OfertaH.Monto6]
Carpeta=Lista
Clave=OfertaH.Monto6
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.OfertaH.Monto7]
Carpeta=Lista
Clave=OfertaH.Monto7
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.OfertaH.Monto8]
Carpeta=Lista
Clave=OfertaH.Monto8
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.OfertaH.Monto9]
Carpeta=Lista
Clave=OfertaH.Monto9
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.OfertaH.Monto10]
Carpeta=Lista
Clave=OfertaH.Monto10
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Articulo=124
Monto1=48
Monto2=47
Monto3=48
Monto4=46
Monto5=50
Monto6=48
Monto7=47
Monto8=48
Monto9=49
Monto10=52
Margen1=54
Margen2=55
Margen3=56
Margen4=56
Margen5=56
Margen6=57
Margen7=55
Margen8=54
Margen9=57
Margen10=58

[Lista.Margen1]
Carpeta=Lista
Clave=Margen1
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro

[Lista.Margen2]
Carpeta=Lista
Clave=Margen2
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro

[Lista.Margen3]
Carpeta=Lista
Clave=Margen3
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro

[Lista.Margen4]
Carpeta=Lista
Clave=Margen4
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro

[Lista.Margen5]
Carpeta=Lista
Clave=Margen5
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro

[Lista.Margen6]
Carpeta=Lista
Clave=Margen6
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro

[Lista.Margen7]
Carpeta=Lista
Clave=Margen7
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro

[Lista.Margen8]
Carpeta=Lista
Clave=Margen8
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro

[Lista.Margen9]
Carpeta=Lista
Clave=Margen9
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro

[Lista.Margen10]
Carpeta=Lista
Clave=Margen10
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro

[Acciones.Cerrar]
Nombre=Cerrar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Acciones.Escala]
Nombre=Escala
Boton=18
NombreEnBoton=S
NombreDesplegar=&Escala
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Expresion=Asigna(Info.Cantidad, SQL(<T>SELECT COUNT(*) FROM OfertaHVol WHERE Estacion=:tEstacion<T>, EstacionTrabajo))<BR>Forma.ActualizarForma
Activo=S
ConCondicion=S
EjecucionCondicion=Forma(<T>OfertaHVol<T>)
Visible=S

[Acciones.Generar]
Nombre=Generar
Boton=7
NombreEnBoton=S
NombreDesplegar=Genera&r
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Ventana
Activo=S
Visible=S
ClaveAccion=Aceptar
ConfirmarAntes=S
DialogoMensaje=EstaSeguro
Antes=S
DespuesGuardar=S
AntesExpresiones=EjecutarSQL(<T>spOfertaHGenerar :nEstacion, :nID<T>, EstacionTrabajo, Info.ID)

[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Enviar/Recibir Excel
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar/Recibir Excel
Activo=S
Visible=S

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Escala
Escala=Generar
Generar=Excel
Excel=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=OfertaH.Articulo
OfertaH.Articulo=OfertaH.Monto1
OfertaH.Monto1=Margen1
Margen1=OfertaH.Monto2
OfertaH.Monto2=Margen2
Margen2=OfertaH.Monto3
OfertaH.Monto3=Margen3
Margen3=OfertaH.Monto4
OfertaH.Monto4=Margen4
Margen4=OfertaH.Monto5
OfertaH.Monto5=Margen5
Margen5=OfertaH.Monto6
OfertaH.Monto6=Margen6
Margen6=OfertaH.Monto7
OfertaH.Monto7=Margen7
Margen7=OfertaH.Monto8
OfertaH.Monto8=Margen8
Margen8=OfertaH.Monto9
OfertaH.Monto9=Margen9
Margen9=OfertaH.Monto10
OfertaH.Monto10=Margen10
Margen10=(Fin)

[Lista.ListaCamposAValidar]
(Inicio)=Art.Descripcion1
Art.Descripcion1=OfertaH.CostoBase
OfertaH.CostoBase=OfertaH.PrecioLista
OfertaH.PrecioLista=MargenPrecioLista
MargenPrecioLista=(Fin)
