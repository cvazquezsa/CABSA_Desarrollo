
[Forma]
Clave=WebEnvolturaImagenTemp
Icono=0
CarpetaPrincipal=Lista
Modulos=(Todos)
MovModulo=(Todos)
Nombre=Envoltura Imagen

ListaCarpetas=Lista
PosicionInicialIzquierda=650
PosicionInicialArriba=316
PosicionInicialAlturaCliente=92
PosicionInicialAncho=588
AccionesTamanoBoton=15x5
AccionesDerecha=S
BarraHerramientas=S
ListaAcciones=Aceptar
VentanaSiempreAlFrente=S
VentanaTipoMarco=Normal
VentanaPosicionInicial=por Diseño
VentanaExclusiva=S
VentanaEscCerrar=S
VentanaEstadoInicial=Normal
VentanaExclusivaOpcion=2
[Lista]
Estilo=Ficha
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=WebEnvolturaImagenTemp
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=WebEnvolturaImagenTemp.Archivo
CarpetaVisible=S

Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
PermiteEditar=S
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
FiltroGeneral=WebEnvolturaImagenTemp.Estacion = {EstacionTrabajo} AND<BR>WebEnvolturaImagenTemp.IDEnvoltura = {Info.ID}
[Lista.WebEnvolturaImagenTemp.Archivo]
Carpeta=Lista
Clave=WebEnvolturaImagenTemp.Archivo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=80
ColorFondo=Blanco

[Lista.Columnas]
Archivo=360

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
GuardarAntes=S
Multiple=S
EnBarraAcciones=S
Activo=S
Visible=S

EnBarraHerramientas=S
ListaAccionesMultiples=(Lista)
[Acciones.Aceptar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Asigna(Info.Directorio,SQL(<T>SELECT WebArtDirectorio FROM WebVersion<T>))<BR>Asigna(Info.Nombre2,SQL(<T> SELECT dbo.fnWebConsecutivoImagenEnvoltura(:nID,:tArchivo)<T>,WebEnvolturaImagenTemp:WebEnvolturaImagenTemp.IDEnvoltura,WebEnvolturaImagenTemp:WebEnvolturaImagenTemp.Archivo))<BR>Directorio.Verificar(Info.Directorio,verdadero )<BR>Asigna(Info.Directorio,Info.Directorio+<T>\<T>+WebEnvolturaImagenTemp:WebEnvolturaImagenTemp.IDEnvoltura)<BR>Directorio.Verificar(Info.Directorio,verdadero )<BR>Asigna(Info.Directorio,Info.Directorio+ <T>\<T>+Info.Nombre2)<BR><BR>CopiarArchivo(WebEnvolturaImagenTemp:WebEnvolturaImagenTemp.Archivo,Info.Directorio  )<BR><BR>EjecutarSQL(<T>spWebEnvolturaInsertarImagen :nID,:tDirectorio<T>,WebEnvolturaImagenTemp:WebEnvolturaImagenTemp.IDEnvoltura,Info.Directorio)
[Acciones.Aceptar.Acepta]
Nombre=Acepta
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S





[Acciones.Aceptar.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Acepta
Acepta=(Fin)
