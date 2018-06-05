[Forma]
Clave=ContCuadre
Nombre=Cuadre Contable (Desde las Cuentas)
Icono=23
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=470
PosicionInicialArriba=300
PosicionInicialAlturaCliente=565
PosicionInicialAncho=979
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
ExpresionesAlMostrar=Asigna(Info.FechaD,  PrimerDiaAño(Hoy))<BR>Asigna(Info.FechaA, Hoy)<BR>Asigna(Info.Desglosar, <T>No<T>)<BR>Asigna(Info.Cuenta, <T>(Todas)<T>)

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ContCuadre
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Cuenta<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
PestanaOtroNombre=S
Filtros=S
FiltroPredefinido=S
FiltroGrupo1=ContCuadre.Cuenta
FiltroValida1=ContCuadre.Cuenta
FiltroNullNombre=(sin clasificar)
FiltroTodo=S
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroTodoFinal=S
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
IconosNombre=ContCuadre:ContCuadre.Cuenta
FiltroGeneral=ContCuadre.Estacion={EstacionTrabajo}

[Lista.ContCuadre.ImporteMov]
Carpeta=Lista
Clave=ContCuadre.ImporteMov
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ContCuadre.ImporteCont]
Carpeta=Lista
Clave=ContCuadre.ImporteCont
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Lista.Columnas]
0=120
1=125

[Lista.Cta.Descripcion]
Carpeta=Lista
Clave=Cta.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.MovNombre]
Carpeta=Lista
Clave=MovNombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreDesplegar=Imprimir
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S

[Acciones.Preliminar]
Nombre=Preliminar
Boton=6
NombreDesplegar=Presentación preliminar
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Enviar a Excel
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S

[Acciones.Personalizar]
Nombre=Personalizar
Boton=45
NombreDesplegar=Personalizar Vista
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Lista.Diferencia]
Carpeta=Lista
Clave=Diferencia
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Ejecutar]
Nombre=Ejecutar
Boton=92
NombreDesplegar=&Ejecutar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S
NombreEnBoton=S
Expresion=Si<BR>  Forma(<T>EspecificarContCuadre<T>)<BR>Entonces<BR>  ProcesarSQL(<T>spContCuadre :nEstacion, :tEmpresa, :fFechaD, :fFechaA, :tCta, :tDesglosar<T>, EstacionTrabajo, Empresa, Info.FechaD, Info.FechaA, Info.Cuenta, Info.Desglosar) <BR>  Forma.ActualizarArbol(<T>Lista<T>) <BR>  Forma.ActualizarVista <BR>Fin

[Lista.ContCuadre.ImporteDirecto]
Carpeta=Lista
Clave=ContCuadre.ImporteDirecto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Totalizador=1

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Ejecutar
Ejecutar=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=Personalizar
Personalizar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=Cta.Descripcion
Cta.Descripcion=MovNombre
MovNombre=ContCuadre.ImporteMov
ContCuadre.ImporteMov=ContCuadre.ImporteCont
ContCuadre.ImporteCont=Diferencia
Diferencia=ContCuadre.ImporteDirecto
ContCuadre.ImporteDirecto=(Fin)
